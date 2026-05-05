# Build Log

Development log tracking progress on the AWS EKS Application Deployment Pipeline.

---

| Date       | What Was Done                                | Why                                                              | Result                                      |
|------------|----------------------------------------------|------------------------------------------------------------------|---------------------------------------------|
| 2026-04-02 | Project structure and documentation initialized | Establish the foundation and scope of the project before building | README.md and BUILD_LOG.md created in repo  |
| 2026-04-02 | Added OIDC auth requirement to CI/CD section    | Pipeline should use OIDC for AWS auth instead of long-lived keys | README.md updated with new requirement      |
| 2026-05-05 | Created simple Python Flask REST API with health endpoint and Dockerfile | Provide a minimal containerized service to deploy through the pipeline | app/ folder added with app.py, requirements.txt, and Dockerfile |
| 2026-05-05 | Wrote Terraform infrastructure for VPC, EKS, ECR, and IAM | Define the cloud foundation as code so the environment is reproducible and reviewable | terraform/ folder with main.tf, variables.tf, outputs.tf, vpc.tf, ecr.tf, eks.tf, iam.tf |
