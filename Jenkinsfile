pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.11.8"
    }
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('terraform-1.0.10')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages {
            stage('Terraform Init'){
            steps {
                dir('terraform_challenge/ec2_instance/'){
                    sh "terraform init -input=false"
                    sh "echo \$PWD"
                    sh "whoami"
                }
            }
        }

        stage('Terraform Format'){
            steps {
                dir('terraform_challenge/ec2_instance/'){
                    sh "terraform fmt -list=true -write=false -diff=true -check=true"
                }
            }
        }

        stage('Terraform Validate'){
            steps {
                dir('terraform_challenge/ec2_instance/'){
                    sh "terraform validate"
                }
            }
        }

        stage('Terraform Plan'){
            steps {
                dir('terraform_challenge/ec2_instance/'){
                    script {
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
                        sh "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' \
                        -out terraform.tfplan;echo \$? > status"
                        stash name: "terraform-plan", includes: "terraform.tfplan"
                    }
                }
            }
        }
        stage('Terraform Apply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('terraform_challenge/ec2_instance/'){
                            unstash "terraform-plan"
                            sh 'terraform apply terraform.tfplan'
                        }
                    }
                }
            }
        }
    }
}