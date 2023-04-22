pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/ambiente que se utilizara para el deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: '¿Ejecutar automáticamente la aplicación después de generar el plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }


    stages {
        stage('Checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/3ddh3rn4nd3z/terraform_challenge.git"
                        }
                    }
                }
            }

        stage('Terraform-Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment} || terraform workspace new ${environment}'

                sh "terraform plan -input=false -out tfplan "
                sh "terraform terraform graph -type=plan | dot -Tpng -o graph.png"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Terraform-Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
               not {
                    equals expected: true, actual: params.destroy
                }
           }
           
                
            

           steps {
               script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Quieres aplicar el plan?",
                    parameters: [text(name: 'Plan', description: 'Revisar el plan', defaultValue: plan)]
               }
           }
       }

        stage('Terraform-Apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
        
        stage('Terraform-Destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
        
        steps {
           sh "terraform destroy --auto-approve"
        }
    }

  }
}