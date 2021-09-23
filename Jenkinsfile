pipeline {
    agent any
        environment {
            GIT_REPO = 'https://github.com/Rajitha-Alawatta/Infrastucture_Provisioning.git'
            REPO_FOLDER = 'Infrastucture_Provisioning'
            OS = 'webserver-image'
            IMAGE_NAME = "test-image"
            PROJECT = "test-environment-262811"
            SOURCE_VM = "base-vm"
            SOURCE_DISK_ZONE = "us-central1-a"
            STORAGE_LOCATION = "us"
            PRIVATE_KEY = '/home/jenkins/.ssh/id_rsa'

        }

    stages {
        stage('Terraform Started') {
            steps {
                sh 'echo "Script started..!" '
            }
        }
        stage('Clone Repo') {
            steps {
                sh "rm -rf ${REPO_FOLDER}"
                sh "git clone ${GIT_REPO}"
            }
        }
        stage('Create Image') {
            steps {
                sh "gcloud compute images create ${IMAGE_NAME} --project=${PROJECT} --source-disk=${SOURCE_VM} --source-disk-zone=${SOURCE_DISK_ZONE} --storage-location=${STORAGE_LOCATION}"
            }
        }
        stage('Initialize Terraform') {
            steps {
                sh "cd ${REPO_FOLDER}"
                sh "terraform init"
            }
        }
        stage('Validate Terraform') {
            steps {
                sh "terraform validate"
            }
        }
        stage('Terraform Plan') {
            steps {
                sh "terraform plan"
            }         
        }
        stage('Terraform Apply') {
            steps {
                sh "terraform apply -var 'image_name=${IMAGE_NAME}' -auto-approve "
            }         
        }
    }
}