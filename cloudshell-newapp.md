# Welcome to Z-Arch!
## In this tutorial you will:
* Install Z-Arch CLI
* Setup your environment
* Bootstrap and deploy a new project

***Prerequisite**: Make sure you have a [https://console.cloud.google.com/billing](billing account) with a card on file before bootstrapping a Z-Arch project. 
This is required to enable certain GCP services that Z-Arch relies on.

## Install the CLI
Before bootstrapping your new project, make sure Z-Arch CLI is installed in your home directory.
```sh
chmod +x ./install.sh && ./install.sh
```
**Tip**: Click the <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> button in the code block above to run the command in your Cloud Shell terminal. 

## Connect to Github
Create a PAT used for bootstrapping new projects.
```sh
zarch connect github
```
  
Later you can replace this with a PAT scoped only to the appropriate project repo.
```sh
zarch connect github --project
```

**Note**: Z-Arch will encrypt and store the PAT locally and to your project's Secret Manager once the project exists. 

## Connect to Cloudflare
Create an access token for bootstrapping new projects.
```sh
zarch connect cloudflare
```
  
Later you can replace this with a token scoped only to the appropriate project repo.
``` sh
zarch connect cloudflare --project
```

**Note**: Z-Arch will encrypt and store the token locally and to your project's Secret Manager once the project exists. 

## Boostrap a Project
### Bootstrap
Run
```sh
zarch new app ~/{{PATH_NAME}}
```
**Tip**: Input the path where you would like the new project to be created. Leave blank if you want it in the home directory.

### Deploy your project's resources as described in the `zarch.yaml`
```sh
zarch deploy all
```
