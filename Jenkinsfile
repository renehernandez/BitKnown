
timestamps {
    node('master') {
        checkout scm

        def testDockerfile = 'Dockerfile.test'
        def version = '0.0.1'

        docker.build("bitknown_test", "-f ${testDockerfile} ./") {
            def packageJSON = readJSON file: 'package.json'
            version = packageJSON.version
            sh "yarn test"
        }

        docker.withRegistry('', 'dockerhub') {
            def image = docker.build("bitknown_ghost:${version}.${env.BUILD_ID}")

            image.push()
            image.push('latest')
        }
    }
}