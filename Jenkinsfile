pipeline {
    agent any
        environment {
            GIT_REPO = 'https://github.com/Rajitha-Alawatta/Infrastucture_Provisioning.git'
            REPO_FOLDER = 'Infrastucture_Provisioning'
            OS = 'webserver-image'
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
            environment {
                new_image_name = "${OS}"
            }
            steps {
                sh """ 
                packer build ./packer.json
                """
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
            environment {
                new_image_name = "${OS}"
            }
            steps {
                sh "terraform apply -var 'image_name=${new_image_name}' -auto-approve "
            }         
        }
    }
}