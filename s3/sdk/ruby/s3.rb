# Load the AWS SDK for S3, Pry (debugging), and SecureRandom for UUIDs.
require 'aws-sdk-s3'
require 'pry'
require 'securerandom'

# Read the bucket name from an environment variable.
# Make sure BUCKET_NAME is exported before running.
bucket_name = ENV['BUCKET_NAME']

# The AWS region where the bucket will exist.
region = "us-east-2"

puts "Using bucket: #{bucket_name}"

# Create an S3 client.
# NOTE: The original version had syntax issues (missing commas).
client = Aws::S3::Client.new(
  region: region
)

resp = client.create_bucket(
    bucket: bucket_name,
    create_bucket_configuration: {
        location_constraint: region
    }
)

# binding.pry

# Randomly decide how many files to generate (1 to 6).
number_of_files = 1 + rand(6)
puts "Number of files to create: #{number_of_files}"

# Loop N times to create and upload files.
number_of_files.times do |i|
  puts "Creating file ##{i}"

  # Generate a file name.
  filename = "file_#{i}.txt"

  # Temporary output path inside the Linux environment.
  output_path = "/tmp/#{filename}"

  # Write a random UUID into the temporary file.
  File.open(output_path, 'w') do |f|
    f.write(SecureRandom.uuid)  # FIX: `SecureRandom..uuid` was a syntax error.
  end

  # Upload the file to S3 as a binary stream.
  File.open(output_path, 'rb') do |f|
    client.put_object(
      bucket: bucket_name,
      key: filename,
      body: f
    )
  end

  puts "Uploaded #{filename} to S3."
end

puts "All files created and uploaded successfully."
