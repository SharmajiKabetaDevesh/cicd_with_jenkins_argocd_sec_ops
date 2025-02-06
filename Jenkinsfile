pipeline{
    agent{
        docker{
            image 'devesh77388/pysonar'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages{
        stage("checkout"){
            steps{
             git branch: 'main', url: 'https://github.com/SharmajiKabetaDevesh/cicd_with_jenkins_argocd_sec_ops.git'
            }
        }
        stage('static code analysis'){
            environment{
                SonarUrl= "http://4.247.173.180:9000"
            }
            steps{
                withCredential([string(credentialsId:'sonarqube',variable:'SONAR_AUTH_TOKEN')])
                sh 'sonar-scanner -X -Dsonar.projectKey="MlDeployment" -Dsonar.login=${SONAR_AUTH_TOKEN} -Dsonar.host.url=${SonarUrl}'
            }
        }
        stage(''){
            environment{
                DOCKER_IMAGE="mldeploymentflask"
                REGISTRY_CREDENTIALS= credentials("docker-cred")
            }
            steps{
               script{
                sh 'docker build -t ${DOCKER_IMAGE} .'
                def dockerImage =docker.image("${DOCKER_IMAGE}")
                docker.withRegistry('https://index.docker.io/v1/', "docker-cred") {
                dockerImage.push()
            }

               }
            }
        }
        stage('Update Files on Git'){
            environment{
            GIT_REPO_NAME = "cicd_with_jenkins_argocd_sec_ops"
            GIT_USER_NAME = "SharmajiKabetaDevesh" 
            }
        steps {
            withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                sh"""
                ls
                git config --global --add safe.directory "*"
                git pull https://github.com/SharmajiKabetaDevesh/cicd_with_jenkins_argocd_sec_ops.git
                git config --user.email "deveshrs2016@gmail.com"
                git config --user.name  ${GIT_USER_NAME}
                git config --user.password ${GITHUB_TOKEN}
                export version =${BUILD_NUMBER}
                export prev_version=$((version-1))
                sed -i "s/flask${prev_version}/flask${version}/g" kubefiles/deployment.yaml
                cat kubefiles/deployment.yaml
                git add kubefiles/deployment.yaml
                git commit -m "Update deployment image to version ${version}"
                git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                """
            }
           
           }
        }

    }
}