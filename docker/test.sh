#!/bin/bash

echo "===== NETWORK TEST ====="
curl -I https://google.com

echo ""
echo "===== AWS TEST ====="
aws sts get-caller-identity

echo ""
echo "===== S3 TEST ====="
aws s3 ls

echo ""
echo "===== DONE ====="
