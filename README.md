Tianqi Zhang 001056916

This is the github repo for csye6225 assignment 8.

Most variables are set in terraform.tfvars. If you want to change the config, just 
change values in the .tfvars file.

Before using this template, you should upload your certification to ACM by this command:
```
aws acm import-certificate --certificate fileb://prod_ethanzhang1997_me.crt --certificate-chain fileb://prod_ethanzhang1997_me.ca-bundle --private-key fileb://private.key --profile prod
```

When everything is set up, just use the commands below to make it work:
```
terraform init
terraform apply
```

When you want to destroy every resource created in the config, just use:
```
terraform destroy
```



