# Deploying a Static Website on Amazon AWS using Terraform

### Objectives

Create an AWS infrastructure to host a static website using Terraform. The infrastructure will include AWS S3 for storing the website files, CloudFront for content delivery, and Route 53 for domain name management. Additional configurations will involve setting up IAM roles and policies, API Gateway, and SSL certificates.

### Prerequisites:

- AWS Account
- Domain name registered in Route 53
- Terraform installed on your local machine

### Tasks:

1. **Initialize the Terraform Project**

   - Run `terraform init` to initialize the Terraform project.
   - Ensure all necessary providers and modules are installed.

2. **Configure AWS S3 Bucket**

   - Create an S3 bucket to host the static website.
   - Configure the bucket policy to make it publicly accessible.
   - Define the `index.html` and `error.html` as the default documents.

3. **Set Up CloudFront Distribution**

   - Create a CloudFront distribution to serve the content from the S3 bucket.
   - Configure the `default_root_object` to point to `index.html`.
   - Integrate the SSL certificate for HTTPS.

4. **Manage Domain with Route 53**

   - Configure Route 53 to manage the custom domain.
   - Create DNS records to point to the CloudFront distribution.

5. **Security and Access Management**

   - Define IAM roles and policies to secure the S3 bucket and CloudFront distribution.
   - Implement least privilege access for IAM roles.

6. **API Gateway Configuration**

   - Configure API Gateway for handling HTTP requests.
   - Define necessary resources and methods in `api_gateway_resources.tf`.

7. **SSL Certificate Configuration**

   - Request and validate an SSL certificate using ACM.
   - Attach the SSL certificate to the CloudFront distribution.

8. **Deployment and Testing**
   - Deploy the infrastructure using `terraform apply`.
   - Verify the deployment by accessing the website via the custom domain.

## Solution

1. **Initialize the Terraform Project**

   - Created an `init.tf` file to set up my providers and region and ran `terraform init`.

2. **Variables Configuration**

   - Created a `variables.tf` file to set up the variables.
   - Added variables to `terraform.tfvars` file.

3. **SSL Certificate**

   - Wrote code to create `certificate.tf` for the SSL certificate.

4. **S3 Bucket Configuration**

   - Created an S3 bucket as a module under a folder named `modules` and named it `s3_bucket.tf`.
   - Inside `s3_bucket.tf`, created an S3 bucket to host the website and defined default documents.
   - Created a bucket policy to make it publicly available.
   - Created an IAM policy to grant public read access to all objects within the S3 bucket.
   - Set a policy on the S3 bucket to control its access permissions.
   - Provisioned an AWS S3 object resource that provisions source files into an S3 bucket.

5. **CloudFront Configuration**

   - Created the `cloudfront.tf` file and provisioned CloudFront.
   - Configured the origin to use the S3 bucket.
   - Set up a custom error response.
   - Specified the domain aliases.
   - Configured the geo-restriction settings.
   - Defined the default cache behavior.
   - Set up the viewer certificate.

6. **Route 53 Configuration**

   - Created a Route 53 hosted zone.
   - Created Route 53 records for domain validation.
   - Created a Route 53 A record with an alias for CloudFront.

7. **Website Module**
   - Created a module named "website" to manage the website infrastructure.

## Usage

Follow these steps to deploy your static website:

1. **Clone the repository:**

   ```
   git clone https://github.com/donfolayan/Static-Website-on-AWS-using-Terraform.git
   cd static-website-terraform
   ```

2. **Configure Terraform:**
   Update the terraform.tfvars file with your domain name, and other configurations.

3. **Configure Amazon CLI:**
   Configure your access keys on Amazon CLI to secure connection

4. **Initialize Terraform:**

   ```
   terraform init
   ```

5. **Plan the deployment:**

   ```
   terraform plan
   ```

6. **Apply the deployment:**

   ```
   terraform apply -auto-approve
   ```

7. **Expect an error:**

   - An error will be thrown during the first launch but this is within expectation,
     The error is due to the Zone53 DNS Nameservers not being configured the Registrar.
     Simply open your Route53 and copy the Nameservers and copy them to your Domain name provider
     then run `terraform apply -auto-approve`

8. **Clean Up**

   - To destroy all the resources created by this project, run:

   ```
   terraform destroy -auto-approve
   ```
