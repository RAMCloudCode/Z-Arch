# QUICK START - Bootstrap a New Project

Click the button below to launch your Google Cloud Shell environment. Follow the tutorial in the sidebar to install Z-Arch and get started. 

<p align="center">
  <a href="https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2FRAMCloudCode%2FZ-Arch&cloudshell_tutorial=tutorials/newapp.md">
    <img src="https://gstatic.com/cloudssh/images/open-btn.svg" alt="Open in Cloud Shell">
  </a>
</p>

> [!WARNING]
> Z-Arch utilizes `gcloud` to invoke project level changes as the signed-in user.  
> Please make sure you are signed into the appropriate Google account before engaging the tutorial.

# Install Z-Arch CLI Locally

## Linux AMD64
Copy the command below into your bash shell to install the cli. 
```bash
curl -fsSL https://raw.githubusercontent.com/RAMCloudCode/Z-Arch/main/install.sh | bash && export PATH="$HOME/.local/bin:$PATH"
```
