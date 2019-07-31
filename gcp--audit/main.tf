
terraform {
  backend "gcs" {}
}

provider "google" {
  region = "australia-southeast1"
  zone = "australia-southeast1-a"
}

data "google_project" "project" {
  project_id = "sandbox--terraform"
}

resource "google_project_service" "service-iam" {
  project = "${data.google_project.project.project_id}"
  service = "iam.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_iam_policy" "project_policy" {
  project = "${data.google_project.project.project_id}"
  policy_data = "${data.google_iam_policy.policy.policy_data}"
}

data "google_iam_policy" "policy" {
  binding {
    role = "roles/resourcemanager.projectIamAdmin"

    members = [
      "serviceAccount:project-editor@sandbox--terraform.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/editor"

    members = [
      "serviceAccount:project-editor@sandbox--terraform.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/storage.objectViewer"

    members = [
      "serviceAccount:project-editor@sandbox--terraform.iam.gserviceaccount.com",
    ]
  }

  binding {
    role = "roles/owner"

    members = [
      "user:Ryuichi.Inagaki.24@gmail.com"
    ]
  }

  binding {
    role = "roles/viewer"

    members = [
      "serviceAccount:sa-manually-created@sandbox--terraform.iam.gserviceaccount.com",
    ]
  }

  audit_config {
    service = "iam.googleapis.com"

    audit_log_configs {
      log_type = "DATA_READ"
    }

    audit_log_configs {
      log_type = "DATA_WRITE"
    }

    audit_log_configs {
      log_type = "ADMIN_READ"
    }
  }
}

resource "google_service_account" "sa" {
  account_id   = "sa-manually-created"
  display_name = "Manually created"
}

resource "google_service_account" "sa2" {
  account_id   = "project-editor"
  display_name = "project-editor"
}
