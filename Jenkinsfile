pipeline {
  agent none
  environment {
    PPA_NAME="ppa:brightbox/ruby-ng"
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
        stage("Bionic") {
          environment { RUBY_VERSIONS="2.3 2.4 2.5" }
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
      }
    }
  }
}
