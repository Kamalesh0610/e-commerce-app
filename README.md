 ## Application Deployment Capstone

This project demonstrates deploying a React application to a production-ready state using Docker, Jenkins, AWS, and monitoring tools.

---

## Application

- **Repo URL:** [https://github.com/Kamalesh0610/e-commerce-app.git](https://github.com/Kamalesh0610/e-commerce-app.git)
- The application runs on **port 80 (HTTP)**.

---

## Docker

- **Dockerfile:** Used to containerize the React application and serve it with Nginx.
- **docker-compose.yml:** Used to run the containerized application.

---

## Bash Scripting

- **build.sh:** Builds Docker images and pushes them to Docker Hub.
- **deploy.sh:** Deploys the Docker image to the server using Docker Compose.

---

## Version Control

- Code is pushed to GitHub on the `dev` branch.
- `.dockerignore` and `.gitignore` files are used for efficient version control.
- All git operations are performed via CLI.

---

## Docker Hub

- Two repositories:
  - **kamalesh0610/dev** (public)
  - **kamalesh0610/prod** (private)
- Images are tagged and pushed according to the branch (`dev` or `master`).

---

## Jenkins

- Jenkins is configured to:
  - Build, push, and deploy the application.
  - Auto-trigger builds from both `dev` and `master` branches.
  - Push images to the appropriate Docker Hub repo based on branch.
- See [Jenkinsfile](Jenkinsfile) for pipeline details.

---

## AWS

- Application is deployed on a **t2.micro EC2 instance**.
- Security Group (SG) configuration:
  - Application accessible from any IP.
  - SSH login restricted to your IP.

---

## Monitoring

- An open-source monitoring system is set up to check application health.
- Notifications are sent if the application goes down.

---

## Submission

- **GitHub Repo URL:** [https://github.com/Kamalesh0610/e-commerce-app.git](https://github.com/Kamalesh0610/e-commerce-app.git)
- **Deployed Site URL:** [http://13.232.157.50](http://13.232.157.50)
- **Docker Images:**
  - `kamalesh0610/dev`
  - `kamalesh0610/prod`
- **Screenshots:** See [`screenshots/`](screenshots/) folder for:
  - Jenkins (login, config, build steps)
  - AWS (EC2 console, SG configs)
  - Docker Hub repos with image tags
  - Deployed site page
  - Monitoring health check status

---


## How to Run

1. **Build Docker Image:**
   ```sh
   ./build.sh <project_name> <version> <branch_name>
   ```
2. **Deploy Application:**
   ```sh
   ./deploy.sh <project_name> <version> <branch_name>
   ```
3. **Access Application:**  
   Visit `http://13.232.157.50>` in your browser.

---

