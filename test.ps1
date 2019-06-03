$testImageName = "bitknown_test"
docker build -f ./Dockerfile.test -t $testImageName .
docker run --rm $testImageName yarn test