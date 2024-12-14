def config = [
    terraform_dir: './terraform',
]

pipeline {
    environment {
        TERRAFORM_DIR=/${config.terraform_dir}/
    }

    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                   withCredentials([file(credentialsId: 'k8sKubeConfig', variable: 'secretFile')]) {
                        sh '''
                            # god help me if I ever do anything concurrently
                            rm -rf ~/.kube && mkdir ~/.kube && chmod 700 ~/.kube && rm -f ~/.kube/config && ln -s ${secretFile} ~/.kube/config
                            cd ${TERRAFORM_DIR}
                            terraform init
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
               withCredentials([file(credentialsId: 'k8sKubeConfig', variable: 'secretFile')]) {
                    sh '''
                        # god help me if I ever do anything concurrently
                        rm -rf ~/.kube && mkdir ~/.kube && chmod 700 ~/.kube && rm -f ~/.kube/config && ln -s ${secretFile} ~/.kube/config
                        cd ${TERRAFORM_DIR}
                        terraform plan
                       '''
               }
            }
        }

        stage('Terraform Apply') {
            steps {
               withCredentials([file(credentialsId: 'k8sKubeConfig', variable: 'secretFile')]) {
                    sh '''
                        # god help me if I ever do anything concurrently
                        rm -rf ~/.kube && mkdir ~/.kube && chmod 700 ~/.kube && rm -f ~/.kube/config && ln -s ${secretFile} ~/.kube/config
                        cd ${TERRAFORM_DIR}
                        terraform apply -auto-approve
                       '''
               }
            }
        }
    }
}
