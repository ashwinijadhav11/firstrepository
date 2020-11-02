## CodeBuild - Create CF stack using Templates in CodeCommit

This Repo will create CloudFormation Template using CodeBuild Service.

### Pre-requisites
- Create a codecommit repository and upload the files using git bash and other git commands like _git add, git commit and git push._
- Create a Codebuild Project from AWS Console with below information:
    - For Operating system, choose Ubuntu.
    - Create environment variables `ENVIRONMENT_NAME` , `VPC_ID`, `SUBNET_ID` to pass the values while executing the build job.
- Add Permissions to create IAM, EC2, CloudFormation to the CodeBuild Role.

#### Repository structure
----------------------------
 - `config` - contains `buildspec.yml` file that will be used by CodeBuild Project.
- `cf_templates` - contains CF templates to create stack.
- `scripts` - contains scripts that runs aws cli commands to create CF stack
