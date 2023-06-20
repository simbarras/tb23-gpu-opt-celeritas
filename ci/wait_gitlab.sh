#!/bin/bash
#* This script is used by GitHub to wait for the GitLab CI to finish
set -e

printf "1 $1\n"
printf "2 $2\n"
printf "3 $3\n"

# Get the status of the GitLab CI
status=$(curl -s --header "PRIVATE-TOKEN: $1" "https://gitlab.forge.hefr.ch/api/v4/projects/$2/pipelines/latest?ref=$3" | jq '.status')

# Wait for the GitLab CI to finish
while [ "$status" != "\"success\"" ] && [ "$status" != "\"failed\"" ] && [ "$status" != "\"canceled\"" ]
do
    printf "Actual status: $status\n"
    sleep 5
    status=$(curl -s --header "PRIVATE-TOKEN: $1" "https://gitlab.forge.hefr.ch/api/v4/projects/$2/pipelines/latest?ref=$3" | jq '.status')
done

# Print the final status
printf "GitLab CI finish with status: $status\n"

if [ "$status" == "\"success\"" ]
then
    exit 0
else
    exit 1
fi


