#!/usr/bin/env bash

# publish_to_ACR.sh loads 
# - saved docker image
# - helm chart
#
# Requirements:
# -- Updated ACR_NAME and ACR_URL values if needed
# -- Logged into azure tenant


set -e -o pipefail

exitmsg() {
  echo "$1"
  exit 1
}

###
### Log into Azure
###

echo "Please log into azure:"
az login --use-device-code


###
###  Setting variables to be used within script
###

ACR_NAME=terra300
ACR_URL=$ACR_NAME.azurecr.io


###
###  Load images to local docker repo
###

echo "Uploading images to local docker repo to prepare for publish..."
cd ..
gunzip -k testapp_image.tar.gz
docker load < testapp_image.tar
echo "Local image upload complete."$'\n'

###
### Login into ACR
###

echo "Logging into ACR..."
az acr login --name $ACR_NAME
echo "Logged in."$'\n'

###
###  Tag and push images to ACR
###

echo "Tagging and publishing images to ACR..."
docker push terra300.azurecr.io/testapp:0.0.1
echo "Image publish complete."$'\n'

###
### Load charts to ACR
###

echo "Logging helm into ACR..."
USER_NAME="00000000-0000-0000-0000-000000000000"
PASSWORD=$(az acr login --name $ACR_NAME --expose-token --output tsv --query accessToken)
helm registry login $ACR_NAME.azurecr.io --username $USER_NAME --password $PASSWORD
echo $'\n'

echo "Publishing helm charts to ACR..."
helm push terra300app-0.1.0.tgz oci://$ACR_URL/helm
echo "Chart publish complete."$'\n'
