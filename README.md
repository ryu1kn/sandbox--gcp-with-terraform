
# Terraform Sandbox

## Update resources in Google Cloud Platform

Terraform config for GCP is under `gcp` directory.

```sh
$ terraform apply \
    -var "gce_ssh_pub_key_file=$HOME/.ssh/google_compute_engine.pub" \
    -var "gce_ssh_user=$(whoami)" \
    gcp
...

Outputs:

ip1 = 35.189.20.142
ip2 = 35.244.104.96
```

Two VMs are in different VPCs that are VPC peered. You can access from one VM to the other.

```sh
$ ssh -A -i ~/.ssh/google_compute_engine 35.189.20.142
ryuichi@terraform-instance-1:~$ ssh 35.244.104.96
ryuichi@terraform-instance-2:~$                     # <-- Login successful
```

## Refs

* [Google Cloud Platform for AWS Professionals: Networking](https://cloud.google.com/docs/compare/aws/networking)
* [Google Cloud Platform Provider](https://www.terraform.io/docs/providers/google/index.html)
* [Getting started with Terraform on Google Cloud Platform](https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform)