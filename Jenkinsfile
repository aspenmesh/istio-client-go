node('docker') {
  timestamps {
    properties([disableConcurrentBuilds()])

    stage('Build') {
      checkout scm
      sh 'make docker-build'
    }
  }
}

