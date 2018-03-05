pipeline {
  agent none
  environment {
    PPA_NAME="ppa:brightbox/ruby-ng-experimental"
  }

  stages {
    stage("Install tests") {
      parallel {
        stage("Trusty") {
          agent {
            docker {
              args '-u 0:0'
              image 'ubuntu:trusty'
            }
          }
          steps {
            sh './install-tests.sh'
          }
        }
        stage("Xenial") {
          agent {
            docker {
              args '-u 0:0'
              image 'ubuntu:xenial'
            }
          }
          steps {
            sh './install-tests.sh'
          }
        }
        stage("Artful") {
          agent {
            docker {
              args '-u 0:0'
              image 'ubuntu:artful'
            }
          }
          steps {
            sh './install-tests.sh'
          }
        }
      }
    }
  }
}
