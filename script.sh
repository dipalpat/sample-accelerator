tanzu accelerator fragment create springboot-version -n accelerator-system --local-path ./sample-accelerator/accelerator-dependency-source-1.2.1 --display-name="Select Spring Boot Version" --source-image gcr.io/pa-dpatel/accelerator/test-sample-acc-fragments --secret-ref acc-credentials --interval 3s

tanzu accelerator fragment create springframework-version -n accelerator-system --local-path ./sample-accelerator/accelerator-dependency-source-1.2.1 --display-name="Select Framework Version" --source-image gcr.io/pa-dpatel/accelerator/test-sample-acc-fragments --secret-ref acc-credentials --interval 3s

tanzu accelerator fragment create database-selection -n accelerator-system --local-path ./sample-accelerator/accelerator-dependency-source-1.2.1 --display-name="Select Database Option" --source-image gcr.io/pa-dpatel/accelerator/test-sample-acc-fragments --secret-ref acc-credentials --interval 3s

tanzu accelerator fragment create messaging-selection -n accelerator-system --local-path ./sample-accelerator/accelerator-dependency-source-1.2.1 --display-name="Select Messaging Option" --source-image gcr.io/pa-dpatel/accelerator/test-sample-acc-fragments --secret-ref acc-credentials --interval 3s

tanzu accelerator create test-acc-with-fragments -n accelerator-system --local-path ./sample-accelerator --display-name="Start Spring Accelerator" --source-image gcr.io/pa-dpatel/accelerator/test-sample-acc-fragments --secret-ref acc-credentials --interval 3s


# tanzu accelerator generate-from-local --accelerator-path test-acc=./sample-accelerator --fragment-paths database-selection=sample-accelerator/accelator-dependency-source-1.2.1/database-selection messaging-selection=./sample-accelerator/accelator-dependency-source-1.2.1/messaging-selection springboot-version=./sample-accelerator/accelator-dependency-source-1.2.1/springboot-version springframework-version=./sample-accelerator/accelator-dependency-source-1.2.1/springframework-version --fragment-names database-selection,java-version,messaging-selection,springboot-version,springframework-version --options-file ./options.json --force -o=./sample-accelerators/test-output
########### Find the bundle image to pull

# imgpkg pull -b registry.pivotal.io/tanzu-application-platform/tap-packages:1.5.0-build.34 -o b
# less b/.imgpkg/images.yml

########### Look for accelerator install SHA and pull bundle in a directory
# imgpkg pull -b registry.pivotal.io/tanzu-application-platform/tap-packages@sha256:bfb20171810ec7329a3f5a72c8c1881a783d1aadaf0c4e198d6e71dcf8ee60c5 -o a

########### Look for acc engine SHA
# less a/.imgpkg/images.yml

########## Pull the acc engine image
# docker pull registry.pivotal.io/tanzu-application-platform/tap-packages@sha256:c50cc242c742a7844b1409a4128755b0b127350b30dfe2a3bbad87159aeaffd2

######### tag the image to simplify run command
# docker tag registry.pivotal.io/tanzu-application-platform/tap-packages@sha256:c50cc242c742a7844b1409a4128755b0b127350b30dfe2a3bbad87159aeaffd2 registry.pivotal.io/tanzu-application-platform/acc-engine:1.5.0-rc2

# docker run -p 8080:8080 registry.pivotal.io/tanzu-application-platform/acc-engine:1.5.0-rc2


    tanzu accelerator generate-from-local \
    --accelerator-path sample-accelerator=./sample-accelerator \
    --fragment-paths java-version=../application-accelerator-samples/fragments/java-version \
    --fragment-paths springboot-version=./sample-accelerator/accelerator-dependency-source-1.2.1/springboot-version \
    --fragment-paths database-selection=./sample-accelerator/accelerator-dependency-source-1.2.1/database-selection \
    --fragment-paths messaging-selection=./sample-accelerator/accelerator-dependency-source-1.2.1/messaging-selection \
    --fragment-paths springframework-version=./sample-accelerator/accelerator-dependency-source-1.2.1/springframework-version \
    --options-file ./sample-accelerator/options.json \
    --force -o=./sample-accelerator/test-output \
    --server-url http://accelerator.tap.xploretanzu.com



