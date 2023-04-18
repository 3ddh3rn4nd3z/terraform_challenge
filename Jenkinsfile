pipeline{
    agent any

    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')        
    }
    environment{
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages{
        stage('Terraform Init'){
            steps {
                echo "terraform init -input=false"
            }
        }
        stage('Terraform Format'){
            steps {
                echo "terraform fmt -list=true -write=false -diff=true -check=true"
            }
        }
        stage('Terraform Validate'){
            steps {
                echo "terraform validate"
            }
        }
        stage('Terraform Plan'){
            steps {
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'ACCESS_KEY'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'SECRET_KEY')])
                script {
                    try {
                        echo "terraform workspace new ${params.WORKSPACE}"
                    } catch (err) {
                        echo "terraform worspace select ${params.WORKSPACE}"
                    }
                    echo "terraform plan \
                    -out terraform.tfplan;echo \$? > status"
                    stash name: "terraform-plan", includes: "terraform.tfplan"
                }
            }
        }
        stage('Terraform Apply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Puedes confirmar si quieres aplicar esto', ok: 'Listo para aplicar la configuracion'
                        apply = true
                    } catch (err) {
                        apply = false
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        unstash "terraform-plan"
                        echo 'terraform apply terraform.tflan'
                    }
                }
            }
        }
    }
}
