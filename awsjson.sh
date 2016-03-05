declare -a instances=("m1.small"  "m1.medium" "m1.large" "m1.xlarge" "m3.medium")
declare -a filenames=("m1small"  "m1medium" "m1large" "m1xlarge" "m3medium")
declare -a zones=("us-west-2" "us-west-1" "eu-west-1" "eu-central-1" "ap-southeast-1" "ap-northeast-1" "ap-southeast-2" "ap-northeast-2")

# get length of an array
instancelength=${#instances[@]}
zonelength=${#zones[@]}

mkdir AWSdata
cd AWSdata
# use for loop to read all values and indexes
for (( j=1; j<${zonelength}+1; j++ ));
do
  aws configure set default.region ${zones[$j-1]}
  mkdir ${zones[$j-1]}
  temp=""
  for (( i=1; i<${instancelength}+1; i++ ));
  do
    aws ec2 describe-spot-price-history --instance-types ${array[$i-1]} 
    temp=${filenames[$i-1]}
  done > ${zones[$j-1]}/temp.json
done
