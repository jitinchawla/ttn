node {
    stage('Checkout') {
    	checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'b0236129-b8f4-4e21-8827-3083abafa57b', url: 'https://github.com/jitinchawla/ttn.git']]])
    }

    stage('Build') {
    	sh 'mvn clean install'
    }

	stage('Build Docker Image'){
		sh 'docker build -t jitinchawla/application:${env.BUILD_NUMBER} .'
	}
	stage('Push Docker Image') {
		withDockerRegistry(credentialsId: 'b0236129-b8f4-4e21-8827-3083abafa57b', toolName: 'Docker', url: 'https://hub.docker.com') {
 		sh 'docker push jitinchawla/application:${env.BUILD_NUMBER}'
	}
	}

	stage('Deploy'){
		sshPublisher(publishers: [sshPublisherDesc(configName: 'docker', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'docker run -itd -P jitinchawla/application:${env.BUILD_NUMBER}', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
	}
}