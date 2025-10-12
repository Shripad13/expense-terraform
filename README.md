# expense-terraform
expense-terraform is the root module which is going to source the remote modules available in tf-module-terraform.git

All the terraform  init, plan, apply will be executed inside this repository & this is referred  as root module and the code from where we are sourcing is referred as backend-module.

All the state info would be supplied in the env-dev, or env-prod  folders & this strategy is to keep the state DRY.




#############################################
## 
> Create the backend module & Source it

> Values used & created in Backend module , declare the empty variable  in root module where you supplying the values

#############################################
## For Use of Ansible-pull
> You need to have ansible install on target nodes - 
>. Steps to make your own AMI :
1.Use lab image & create instance
2. Install ansible on that node using "pip3.11 install ansible"
3. Create  an AMI using this & name it as "b58-golden-image"
4. Make sure you are the owner , so supply your account id.
#############################################