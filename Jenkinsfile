pipeline {
  agent none
  environment {
    PPA_NAME="ppa:brightbox/ruby-ng-experimental"
  }

  stages {
    stage("Install tests") {
      parallel {
        stage("Xenial") {
          environment { RUBY_VERSIONS="1.9.1 1.8 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7" }
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
        stage("Bionic") {
          environment { RUBY_VERSIONS="2.3 2.4 2.5 2.6 2.7" }
          agent {
            docker {
              args '-u 0:0'
              image 'ubuntu:bionic'
            }
          }
          steps {
            sh './install-tests.sh'
          }
        }
        stage("Focal") {
          environment { RUBY_VERSIONS="2.7" }
          agent {
            docker {
              args '-u 0:0'
              image 'ubuntu:focal'
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
