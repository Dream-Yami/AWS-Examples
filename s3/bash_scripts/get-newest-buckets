#!/bin/bash
aws s3api list-buckets --query 'Buckets | sort_by(@, &CreationDate) | [-1:].Name' --output text