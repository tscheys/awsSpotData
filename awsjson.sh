#declare instance types and zones to extract
declare -a instances=("m1.medium" "c3.large" "g2.2xlarge")
declare -a zones=("eu-west-1" "us-west-2" "ap-southeast-1")
declare -a dates=() 
#create array of past 90 days 
for ((days=89; days>0; days--));
do
  dates+=($(date -j -v-${days}d +%Y-%m-%d))
done

# get number of instances, zones, dates
instancelength=${#instances[@]}
zonelength=${#zones[@]}
dateslength=${#dates[@]}

# loop through zones
for (( j=1; j<${zonelength}+1; j++ ));
do
  # configure default region to zone in loop
  aws configure set default.region ${zones[$j-1]}
  for (( i=1; i<${instancelength}+1; i++ ));
  do
    #loop over past 90 days 
    for ((k=1; k<${dateslength}+1; k++));
    do
      # extract data in json format of current region, instance in loop
      # use jq to make json compact, to be usable later in apache spark 
      aws ec2 describe-spot-price-history --instance-types ${instances[$i-1]} --product-description "Linux/UNIX" --start-time ${dates[$k-1]}T00:00:00.000Z --end-time ${dates[$k-1]}T23:59:59.000Z | jq -c ".SpotPriceHistory[]"
      # append data to outputted json file
    done >> aws.json
  done
done


# aborts run with ctrl-c
control_c() {
    kill $PID
    exit
}
