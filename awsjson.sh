declare -a instances=("m1.small"  "m3.medium")
declare -a filenames=("m1small" "m3medium")
declare -a zones=("us-west-2" "us-west-1")

# get length of an array
instancelength=${#instances[@]}
zonelength=${#zones[@]}

# use for loop to read all values and indexes
for (( j=1; j<${zonelength}+1; j++ ));
do
  aws configure set default.region ${zones[$j-1]}
  for (( i=1; i<${instancelength}+1; i++ ));
  do
    aws ec2 describe-spot-price-history --instance-types ${instances[$i-1]} --product-description "Linux/UNIX" | jq -c ".SpotPriceHistory[]"
  done >> aws2.json
done


# > ${zones[$j-1]}/${temp}.json
control_c() {
    kill $PID
    exit
}
