## This reposistory is created with learning purposes for Terraform Enterprise, focusing on TFE state.

## Purpose :

- It provides a simple example of how to use Terraform, and fetch the Terraform state output section from the state file stored in TFE.


## Part 1:
----------------------------------
- Firstly, TFE workspace needs to be created, use the instructions form [here](https://www.terraform.io/docs/enterprise/workspaces/index.html)

- Connect the workspace that has been created with VCS, in this case GitHub, using the instructions [here](https://www.terraform.io/docs/enterprise/vcs/index.html)

- Now clone this repository and add your repository that is connected to TFE workspace :
```shell
git remote -v # Review you have only one remote repo named "origin"
git add remote repoTFE URL_OF_YOUR_GITHUB_REPO_THAT_IS_CONNECTED_TO_TFE_WORKSPACE
git remote -v # Review you have two remotes
git checkout -b addContent  # To checkout into new branch named "addContent"
git add . # To stage all the files
git commit -m "Adding initial content to repoTFE" # Initial commit
git push repoTFE addContent # Pushing "addContent" branch to remote GitHub repo "repoTFE" which is connected to TFE workspace.
```
- The procedure so far, would trigger `terraform plan` in the TFE workspace that is connected to your `repoTFE`.
- After the `plan` phrase finishes, apply the changes in TFE.
- You can see that Terraform has generated random pet name, the output in your TFE would look like this :
```shell
Initializing plugins and modules...
2019/06/20 07:27:37 [DEBUG] Using modified User-Agent: Terraform/0.12.2 TFE/3ebf0c4
random_pet.example: Creating...
random_pet.example: Creation complete after 0s [id=routinely-routinely-ample-ant]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

name = routinely-routinely-ample-ant # THIS NAME IS GOING TO BE USED
```

## Part 2:
----------------------------------
- Now, go one directory back and clone [this](https://github.com/martinhristov90/tfeNullRemotePet.git) using :
```
cd ..
git clone https://github.com/martinhristov90/tfeNullRemotePet.git
cd tfeNullRemotePet
```
- This repository contains `main.tf` file which is going to consume the output section of the `state` file stored in the TFE workspace.
- Get your user token by going to [here](https://app.terraform.io/app/settings/tokens) and enter a description, what the token is going to be used for, for example "exerciseToken" and click `generate`, copy the string.
- Enter the token as environment variable :
```
export ATLAS_TOKEN=YOUR_TOKEN_HERE
```
- Execute `terraform init`.
- Execute `terraform apply`. The output should look like this: 
```shell
null_resource.hello: Creating...
null_resource.hello: Provisioning with 'local-exec'...
null_resource.hello (local-exec): Executing: ["/bin/sh" "-c" "echo Hello routinely-routinely-ample-ant"]
null_resource.hello (local-exec): Hello routinely-routinely-ample-ant # IT IS THE SAME 
null_resource.hello: Creation complete after 0s [id=234437177665750948]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
As you can see the by using the `terraform_remote_state` we were able to fetch the name of the random pet.

