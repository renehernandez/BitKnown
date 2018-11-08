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
            def testDockerfile = 'Dockerfile.test'
            stage('Build Test Image') {
                sh "docker build -f ${testDockerfile} -t bitknown_test ./"
            }

            stage('Run Tests') {
                sh "docker run --rm bitknown_test yarn test"
            }

            stage('Get Version') {
                def testImage = docker.image("bitknown_test") 
                
                testImage.inside {
                    def packageJSON = readJSON file: 'package.json'
                    version = packageJSON.version
                }
            }

            stage('Build Production Image') {
                def formattedVersion = formatVersion(version)
                def image = docker.build("renehr9102/bitknown_ghost:$formattedVersion")

                stage("Publish image with tag $formattedVersion") {
                    docker.withRegistry('', 'dockerhub') {
                        image.push()

                        if (isReleaseVersion()) {
                            stage('Update latest tag') {
                                image.push('latest')
                            }
                        }
                    }
                }
            }
        }
        finally {
            sh "docker rmi bitknown_test"

            if (version) {
                sh "docker rmi renehr9102/bitknown_ghost:${formatVersion(version)}"
            }
        }
    }
}