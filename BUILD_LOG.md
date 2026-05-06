# Build Log

Development log tracking progress on the AWS EKS Application Deployment Pipeline.

---

| Date       | What Was Done                                | Why                                                              | Result                                      |
|------------|----------------------------------------------|------------------------------------------------------------------|---------------------------------------------|
| 2026-04-02 | Project structure and documentation initialized | Establish the foundation and scope of the project before building | README.md and BUILD_LOG.md created in repo  |
| 2026-04-02 | Added OIDC auth requirement to CI/CD section    | Pipeline should use OIDC for AWS auth instead of long-lived keys | README.md updated with new requirement      |
| 2026-05-05 | Created simple Python Flask REST API with health endpoint and Dockerfile | Provide a minimal containerized service to deploy through the pipeline | app/ folder added with app.py, requirements.txt, and Dockerfile |
| 2026-05-05 | Wrote Terraform infrastructure for VPC, EKS, ECR, and IAM | Define the cloud foundation as code so the environment is reproducible and reviewable | terraform/ folder with main.tf, variables.tf, outputs.tf, vpc.tf, ecr.tf, eks.tf, iam.tf |
| 2026-05-05 | Documented ephemeral-infrastructure / cost management approach in PORTFOLIO.md | Make it explicit that the stack is spun up on demand and torn down after use to avoid idle AWS spend | PORTFOLIO.md updated with a Cost Management section |
| 2026-05-05 | Added Helm chart for the Flask app | Package the Kubernetes manifests so the pipeline can deploy with a single `helm upgrade --install` and override the image tag per build | helm/ chart with Chart.yaml, values.yaml, deployment, service, serviceaccount, and _helpers.tpl |
| 2026-05-05 | Cleaned up repository by removing local tooling artifacts from git tracking | Keep machine-specific local files out of the shared repo so it stays portable across environments | .claude/ untracked via `git rm --cached` and grouped under a generic `# local` section in .gitignore |
| 2026-05-05 | Added GitHub Actions CI/CD pipeline | Automate build, image push, and Helm deploy on every push to main, with OIDC-based AWS auth so no long-lived keys live in GitHub Secrets | .github/workflows/deploy.yml builds from app/, tags with the commit SHA, pushes to ECR, updates kubeconfig, and runs `helm upgrade --install` against the EKS cluster |
| 2026-05-06 | Added ECR lifecycle policy retaining only the last 10 images | Prevent unbounded image growth in ECR as every push to main creates a new SHA-tagged image, which would otherwise accumulate storage cost over time | terraform/ecr.tf now defines an `aws_ecr_lifecycle_policy` that expires any image beyond the most recent 10 |
| 2026-05-06 | Ran the full pipeline end to end against real AWS | Validate that every piece of the project actually works together, not just in isolation | Provisioned the stack with `terraform apply`, pushed to `main` to trigger GitHub Actions, watched the workflow build the image, OIDC-auth into AWS, push to ECR, and `helm upgrade --install` against EKS, then hit the load balancer endpoint from my local machine and got a healthy response from the API |
