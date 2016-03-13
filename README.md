#Why use this 
If for some reason you need to extract a lot AWS spot price data using their describe-spot-price CLI command. 

At this moment the script is tailored to my needs, so you might have to tinker a bit to get what you want. 

This script also uses jq to make the output json suitable for apache spark analysis.

#Instructions 

1. Install jq with brew install jq `brew install jq`

2. Give permission to execute this script: `chmod +x awsjson.sh`

3. Run it with: `./awsjson.sh`
