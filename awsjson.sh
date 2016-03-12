#declare instance types and zones to extract
declare -a instances=("m1.small"  "m3.medium")
declare -a filenames=("m1small" "m3medium")
declare -a zones=("us-west-2" "us-west-1")

# get number of instances, zones
instancelength=${#instances[@]}
zonelength=${#zones[@]}

# loop through zones
for (( j=1; j<${zonelength}+1; j++ ));
do
  # configure default region to zone in loop
  aws configure set default.region ${zones[$j-1]}
  for (( i=1; i<${instancelength}+1; i++ ));
  do
    # extract data in json format of current region, instance in loop
    # use jq to make json compact, to be usable later in apache spark 
    aws ec2 describe-spot-price-history --instance-types ${instances[$i-1]} --product-description "Linux/UNIX" | jq -c ".SpotPriceHistory[]"
    # append data to outputted json file
  done >> aws2.json
done


# aborts run with ctrl-c
control_c() {
    kill $PID
    exit
}
