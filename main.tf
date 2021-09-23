provider "google" {
  project     = "${var.gcp_project_id}"
  region      = "${var.region}"
  credentials = "${file("credenntials.json")}"
  #version = "~> 1.60.1"
}

## GCP Instance Template ##

resource "google_compute_instance_template" "test_instance_template" {
  name        = "${var.instance_template}"
  description = "This template is used to create test server instances."

  labels = {
    environment = "${var.env}"
  }

  instance_description = "description assigned to instances"
  machine_type         = "${var.vm_type}"

  scheduling {
    automatic_restart   = true
  }

  // Create a new boot disk from an image
  disk {
    source_image      = "${var.image_name}"
  }

  network_interface {
    network = "${var.nic}"

    access_config {
      // Ephemeral public IP
    }
  }

  #metadata_startup_script = "echo hi > /test.txt"
  metadata_startup_script = <<SCRIPT
  ${file("${var.startup_script}")}
  SCRIPT

  
  metadata = {
    environment = "${var.data}"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "${var.sa_email}"
    scopes = ["cloud-platform"]
  }
}


## GCP Instance Group ## 

resource "google_compute_instance_group_manager" "test_instance_group" {
  name = "${var.group_name}"

  base_instance_name = "${var.vm_name}"
  zone               = "${var.zone}"

  version {
  instance_template  = google_compute_instance_template.test_instance_template.id
  }

  target_size  = 2
}


## AutoHealing ##

#resource "google_compute_health_check" "autohealing" {
#  name                = "${var.autohealing_name}"
#  check_interval_sec  = 5
#  timeout_sec         = 5
#  healthy_threshold   = 2
#  unhealthy_threshold = 10 # 50 seconds

#  http_health_check {
#    request_path = "/healthz"
#    port         = "8080"
#  }