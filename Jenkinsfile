/*pipeline {
    agent any
    tools {
        maven 'Maven 3.2.1'
        jdk 'jdk8'
        docker 'myDocker'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn install -Dmaven.test.skip=true'
            }
        }

    }
}*/

def CONTAINER_NAME="my-pipeline"
def CONTAINER_TAG="latest"
def DOCKER_HUB_USER="saileshdb"
def HTTP_PORT="8099"
def PASSWORD="Nby8mSzCH9zu5tm"

node {

	stage ('Initialize') {
		def dockerHome = tool 'myDocker'
		def mavenHome = tool 'myMaven'
		env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
		echo "PATH = ${env.PATH}"
	}

	stage ('Checkout') {
	    checkout scm
	}

	stage ('Build') {
		sh 'mvn clean install'
	}

	//stage ('Image Prune') {
	//	imagePrune(CONTAINER_NAME)
	//}

	stage ('Image Build') {
		imageBuild(CONTAINER_NAME, CONTAINER_TAG)
	}

	stage('Push to Docker Registry') {
		withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_HUB_USER', passwordVariable: 'PASSWORD')])
		pushToImage(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, PASSWORD)
	}

	stage('Run App'){
		runApp(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, HTTP_PORT)
	}
}

def imagePrune(containerName){
	try{
		sh "docker image prune -f"
		sh "docker stop $containerName"
	} catch(error){}
}

def imageBuild(containerName, tag){
	sh "docker build -t $containerName:$tag  -t $containerName --pull --no-cache ."
	echo "Image build complete"
}

def pushToImage(containerName, tag, dockerUser, dockerPassword){
    echo "USER = $dockerUser"
	sh "docker login -u $dockerUser -p $dockerPassword"
	sh "docker tag $containerName:$tag $dockerUser/$containerName:$tag"
	sh "docker push $dockerUser/$containerName:$tag"
	echo "Image push complete"
}

def runApp(containerName, tag, dockerHubUser, httpPort){
	sh "docker pull $dockerHubUser/$containerName"
	sh "docker run -d --rm -p $httpPort:$httpPort --name $containerName $dockerHubUser/$containerName:$tag"
	echo "Application started on port: ${httpPort} (http)"
}