def isReleaseVersion(){
    return env.BRANCH_NAME == 'master'
}

def formatVersion(def version) {
    if (!isReleaseVersion()) {
        return "${version}-${env.BRANCH_NAME}${env.BUILD_ID}"
    }
    return "${version}.${env.BUILD_ID}"
}

timestamps {
    node('master') {
        checkout scm
        def version = ''

        try{
            stage('Test') {
                def testDockerfile = 'Dockerfile.test'
                sh "docker build -f ${testDockerfile} -t bitknown_test ./"
                sh "docker run --rm bitknown_test yarn test"
                
                def testImage = docker.build("bitknown_test", "-f ${testDockerfile} ./") 
                
                testImage.inside {
                    def packageJSON = readJSON file: 'package.json'
                    version = packageJSON.version
                }
            }
    
            stage('Publish to DockerHub') {
                docker.withRegistry('', 'dockerhub') {
                    def image = docker.build("renehr9102/bitknown_ghost:${formatVersion(version)}")
                    image.push()

                    if (isReleaseVersion()) {
                        image.push('latest')
                    }
                }
            }
        }
        finally {
            sh "docker rmi bitknown_test"

            if (version) {
                sh "docker rmi renehr9102/bitknown_ghost"
                sh "docker rmi renehr9102/bitknown_ghost:${formatVersion(version)}"
            }
        }
    }
}