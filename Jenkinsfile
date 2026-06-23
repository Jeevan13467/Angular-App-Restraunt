pipeline {
    agent any 
    
    environment {
        DOCKER_IMAGE = 'angular-app1'
        DOCKERHUB_USERNAME = 'jeevan7790'
        DOCKERHUB_ACCESS_TOKEN = credentials('dockerhub-access-token')
        DOCKER_REGISTRY = 'jeevan7790/angular-app'
    }
    
    // OPEN STAGES ONCE HERE
    stages {
        
        stage('checkout/source') {
            steps {
                git 'https://github.com/Jeevan13467/Angular-App-Restraunt.git'
            }
        }
        
        stage('Build Docker image') {
            steps {
                script {
                    // Fixed missing quotes around your docker build command here too!
                    sh "docker build -t ${DOCKER_IMAGE} ." 
                }
            }
        }
        
    
      stage('Push to Docker Registry') {
            steps {
                script {
                    sh """
                    echo "${DOCKERHUB_ACCESS_TOKEN}" |docker login -u "${DOCKERHUB_USERNAME}" --password-stdin
                    docker tag ${DOCKER_IMAGE} ${DOCKER_REGISTRY}:latest
                    docker push ${DOCKER_REGISTRY}:latest
                    """
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh """
                    docker run -d -p 5001:80 ${DOCKER_IMAGE}
                    """
                }
            }
        }
        
    } // CLOSE STAGES ONCE HERE
    
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
   
