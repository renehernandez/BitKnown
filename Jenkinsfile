
timestamps {
    node('master') {

        checkout scm

        docker.image('node:9').inside {
            sh "node --version"
        }
    }
}