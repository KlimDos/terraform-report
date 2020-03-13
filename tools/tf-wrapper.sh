#!/bin/bash
# tf - helper script to initialize backend and plan/apply Terraform code in one command

if [ -z "$1" ] || [ -z "$2" ] || [ ! -z "$3" ]
then
    echo "Script invocation should contain exactly 2 parameters: command and environment, e.g. '$0 plan dev'"
else
    if [ -f variables/"$2".tfvars ]
    then
        if [ "$1" = "plan" ]
        then
            terraform init -reconfigure -backend-config=variables/"$2".tfvars
            terraform plan --var-file=variables/"$2".tfvars
        elif [ "$1" = "apply" ]
        then
            terraform init -reconfigure -backend-config=variables/"$2".tfvars
            terraform apply --var-file=variables/"$2".tfvars
        elif [ "$1" = "plandestroy" ]
        then
            terraform init -reconfigure -backend-config=variables/"$2".tfvars
            terraform plan -destroy --var-file=variables/"$2".tfvars
        elif [ "$1" = "show" ]
        then
            terraform init -reconfigure -backend-config=variables/"$2".tfvars
            terraform show 
        elif [ "$1" = "destroy" ]
        then
            terraform init -reconfigure -backend-config=variables/"$2".tfvars
            terraform destroy --var-file=variables/"$2".tfvars
        else
            echo "Unknown command '$1'. Accepted commands: 'plan', 'apply', 'plandestroy', 'destroy'"
        fi
    else
        echo "No variables/$2.tfvars file found. You should run this script from TF root directory"
    fi
fi