# 📌 Project Name: `serverless-image-processing-pipeline-by-github-actions`

## 📝 Project Description

This project is a fully serverless cloud-native application built on AWS, showcasing the integration of infrastructure as code, CI/CD automation, and scalable backend services.

It uses:
- **AWS Lambda** for running Python-based backend logic  
- **AWS Step Functions** to orchestrate workflows and connect services together  
- **Amazon DynamoDB** as a NoSQL database  
- **Amazon S3** for object storage
- **AWS API Gateway** to expose HTTP endpoints for consumers
- **Amazon EventBridge** to trigger workflows on S3 upload events      
- **Terraform** to provision and manage all cloud resources as infrastructure-as-code  
- **Github Actions** for orchestrating the CI/CD pipeline:
  - Run `terraform plan` in one stage
  - Run `terraform apply` in another stage  
- **Slack** Integration for real-time DevOps notifications
---

## 🚀 Key Features

- Fully serverless and event-driven architecture  
- Scalable backend using DynamoDB and S3  
- Image processing using AWS Lambda and Step Functions  
- Secure file upload with pre-signed URLs  
- Automated image text extraction using AWS Rekognition  
- Clean CI/CD pipeline using Github Actions
- Infrastructure as Code with Terraform and manual approval gate 

- Slack notifications on key pipeline events:
    - Custom Slack message sent on deployment failures

    - Notification sent to Slack after successful PR creation

---

## 🔁 Workflow Steps

1. **User calls an API Gateway endpoint**  
   - Triggers a Lambda function that:
     - Generates a `job_id` using UUID  
     - Creates a pre-signed S3 URL for uploading an image  
     - Stores a new entry in DynamoDB with:
       - `job_id`
       - `status = upload_pending`
       - `image_key`

2. **User uploads the image using the pre-signed URL**  
   - The image is PUT directly into the source S3 bucket  

3. **S3 triggers an EventBridge rule**  
   - When a new file is uploaded, an event is triggered that starts a Step Function execution  

4. **Step Function Workflow**  
   - **Check file type**: If not PNG, terminate and mark job as failed in DynamoDB  
   - **Text extraction**: Use AWS Rekognition to extract text  
   - **Upload processed image to another S3 bucket**  
   - **Update job status in DynamoDB** with result and image path  

---

## ⚙️ CI/CD Pipeline Details

- **Github Actions Stages**:
  1. **Source**: Pulls Terraform code from version control  
  2. **Plan**: Executes `terraform plan`  
  3. **Approval**: Manual approval stage  
  4. **Apply**: Executes `terraform apply`  

- **Slack Integration:**
  1. 🚨 Sends an alert to a Slack channel when a deployment fails 
  2. 📣 Sends a Slack message on successful pull request creation 
---

## 📦 Tech Stack

- AWS Lambda (Python)  
- AWS Step Functions  
- Amazon S3  
- Amazon DynamoDB  
- AWS Rekognition  
- Github Actions 
- Terraform
- AWS API Gateway
- AWS Eventbridge  
- Slack (custom integration for CI/CD notifications)
