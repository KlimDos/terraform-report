#!/bin/bash -xe
export AWS_DEFAULT_REGION=us-east-1
export AWS_PROFILE=nonprod
aws-azure-login --profile nonprod


WORKDIR="/Users/sasha/Desktop/git/wiley/do-infrastructure/cloud/aws/contenttech/"
#DOCKERDIR="/Users/sasha/Desktop/docker_builds/"
DOCKERDIR="$(dirname "$(pwd)")"

#declare -a SYSTEMS=("CK" "CMH" "DCM" "CTSS")
declare -a SYSTEMS=("CTSS")
declare -a ENVS=("dev" "perf" "qa" "sit" "uat" "ppd")
#declare -a ENVS=("dev")
cd $WORKDIR
if [ "$1" == "plan" ] 
then
    for i in "${SYSTEMS[@]}"
    do
    cd "$i"
    for j in "${ENVS[@]}"
        do
        pwd
            "$DOCKERDIR"/tools/tf-wrapper.sh plan "$j" > "$DOCKERDIR"/in/"$i"-"$j".report
        done
    cd ..
    done

    cd $DOCKERDIR
    docker run -it -v "$DOCKERDIR":/tmp/ converter:0.3
    #docker run -it -v /Users/sasha/Desktop/docker_builds/:/tmp/ converter:0.2
fi
if [ "$1" == "apply" ]
then
    for i in "${SYSTEMS[@]}"
    do
    cd "$i"
    for j in "${ENVS[@]}"
        do
            "$DOCKERDIR"/tools/tf-wrapper.sh apply "$j"
        done
    cd ..
    done
else
 echo "usage: "
fi