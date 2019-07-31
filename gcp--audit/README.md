
# GCP Audit Logging

## Usage

```sh
$ export GOOGLE_APPLICATION_CREDENTIALS=/path/to/key.json
$ terraform init -reconfigure -backend-config=dev.tfbackend
$ terraform apply
```

[IAM policy for projects](https://www.terraform.io/docs/providers/google/r/google_project_iam.html#google_project_iam_binding)
