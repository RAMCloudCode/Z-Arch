# Welcome to Z-Arch!
## In this tutorial you will:
* Install Z-Arch CLI
* Setup your environment
* Bootstrap and deploy a new project

**Prerequisite**: Make sure you have a [billing account](https://console.cloud.google.com/billing) with a card on file before bootstrapping a Z-Arch project. 
This is required to enable certain GCP services that Z-Arch relies on.

## Install the CLI
Before bootstrapping your new project, make sure Z-Arch CLI is installed in your home directory:
```sh
chmod +x ./install.sh && ./install.sh
```
**Tip**: Click the <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> button in the code block above to copy the command to your Cloud Shell terminal. 

## Connect to Github
Create a PAT used for bootstrapping new projects:
```sh
zarch connect github
```
**Note**: Z-Arch will encrypt and store the PAT locally and to your project's Secret Manager once the project exists. 

### Later 
You should replace this with a PAT scoped only to the appropriate project repo:
```sh
zarch connect github --project
```

## Connect to Cloudflare
Create an access token for bootstrapping new projects:
```sh
zarch connect cloudflare
```
**Note**: Z-Arch will encrypt and store the token locally and to your project's Secret Manager once the project exists. 
  
### Later 
You should replace this with a token scoped only to the appropriate project resources:
``` sh
zarch connect cloudflare --project
```

## Go Live!
### Bootstrap Project
```sh
zarch new app ~/{{PATH_NAME}}
```
**Tip**: Input the path where you would like the new project to be created. Leave blank if you want it in the home directory.

### Deploy Resources
Your project's resources are described in the `zarch.yaml`. Run the command below when you are ready to deploy them.
```sh
zarch deploy all
```
