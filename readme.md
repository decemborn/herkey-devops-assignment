# Herkey DevOps Assignment

Containerized Python Flask web application deployed to Google Kubernetes Engine (GKE) via a GitHub Actions CI/CD pipeline utilizing Workload Identity Federation for secure authentication.

## Architecture
* **Application:** Node.js/Python (Flask)
* **Containerization:** Docker
* **Registry:** Google Artifact Registry
* **Orchestration:** GKE
* **CI/CD:** GitHub Actions (OIDC/WIF Authenticated)
* **Monitoring:** GCP Uptime Checks & Kubernetes Liveness/Readiness Probes

## Deployment Steps
1. Push code to the `main` branch.
2. GitHub Actions authenticates securely to GCP via Workload Identity Federation.
3. The Docker image is built, tagged with the commit SHA, and pushed to Artifact Registry.
4. GKE credentials are fetched.
5. The `IMAGE_PLACEHOLDER` in `k8s/deployment.yaml` is replaced with the new image tag.
6. The updated manifests are applied to the GKE cluster.

## Troubleshooting
* **ImagePullBackOff:** Verify the GCP Service Account has `roles/artifactregistry.reader` on the GKE nodes, or ensure the pipeline successfully pushed the image to Artifact Registry.
* **Authentication Failures in CI/CD:** Ensure the GitHub Secrets (`GCP_WIF_PROVIDER`, `GCP_SERVICE_ACCOUNT`, `GCP_PROJECT_ID`) are correct and that the GitHub repository string in the WIF binding perfectly matches `owner/repo`.
* **CrashLoopBackOff:** Check application logs via `kubectl logs -l app=herkey-flask-app`. Verify the `/healthz` endpoint is returning a 200 status within the timeout defined in the probes.