variable "region" {
  default = "us-central1"
}

variable "gcp_project_id" {
    default = "test-environment-262811"
}

variable "vm_name" {
  default = "test-vm"
}

variable "vm_type" {
    default = "e2-small"
}

variable "zone" {
    default = "us-central1-a"
}

variable "image_name" {
    default = "centos-cloud/centos-7"
}

variable "nic" {
    default = "default"
}

variable "instance_template" {
    default = "test-template"
}

variable "env" {
    default = "test"
}

variable "data" {
    default = "test"
}

variable "sa_email" {
    #default = "terraform@test-environment-262811.iam.gserviceaccount.com"
    default = "gcp-provisioning-terraform@test-environment-262811.iam.gserviceaccount.com"
}

variable "group_name" {
    default = "test-group"
}

variable "autohealing_name" {
    default = "gcp_autohealer"
}

variable "startup_script" {
    default = "startup_script.sh"
}