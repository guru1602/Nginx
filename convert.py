#!/usr/bin/env python

import glob
import json
import os
import uuid
import boto3
import datetime
import random

from botocore.client import ClientError

def handler(event, context):
    
    sourceS3Bucket = event['Records'][0]['s3']['bucket']['name']
    sourceS3Key = event['Records'][0]['s3']['object']['key']
    
    # below 4 lines will extract the folder path from input and replace 'upload' to 'videos' under destination path, and assign assetID    
    outputS3path = sourceS3Key
    result = outputS3path.rsplit('/', 1)
    destinationS3path = result[0].replace("upload", "videos")  
    assetID = result[0].replace("consumerduty/upload/", "")
    
    sourceS3 = 's3://'+ sourceS3Bucket + '/' + sourceS3Key
    sourceS3Basename = os.path.splitext(os.path.basename(sourceS3))[0]
    destinationS3 = 's3://' + os.environ['DestinationBucket']
    #destinationS3basename = os.path.splitext(os.path.basename(destinationS3))[0]
    mediaConvertRole = os.environ['MediaConvertRole']
    region = os.environ['AWS_DEFAULT_REGION']
    statusCode = 200
    body = {}
    
    # Use MediaConvert SDK UserMetadata to tag jobs with the assetID 
    # Events from MediaConvert will have the assetID in UserMedata
    jobMetadata = {'assetID': assetID}

    print (json.dumps(event))
    
    try:
        # to validate if the file uploaded is mp4 or mov format
        extensionToCheck = ('.mp4' , '.mov')
        ext = sourceS3Key.endswith(extensionToCheck)
        if ext != True:
           raise Exception("not a valid file format")
   
        # Job settings are in the lambda zip file in the current working directory
        with open('job.json') as json_data:
            jobSettings = json.load(json_data)
            print(jobSettings)
        
        # get the account-specific mediaconvert endpoint for this region
        mc_client = boto3.client('mediaconvert', region_name=region)
        endpoints = mc_client.describe_endpoints()

        # add the account-specific endpoint to the client session 
        client = boto3.client('mediaconvert', region_name=region, endpoint_url=endpoints['Endpoints'][0]['Url'], verify=False)

        # Update the job settings with the source video from the S3 event and destination 
        # paths for converted videos
        jobSettings['Inputs'][0]['FileInput'] = sourceS3
        
    
        S3KeyWatermark = destinationS3path + '/' + sourceS3Basename
        jobSettings['OutputGroups'][0]['OutputGroupSettings']['FileGroupSettings']['Destination'] \
            = destinationS3 + '/' + S3KeyWatermark
      

        print('jobSettings:')
        print(json.dumps(jobSettings))

        # Convert the video using AWS Elemental MediaConvert
        job = client.create_job(Role=mediaConvertRole, UserMetadata=jobMetadata, Settings=jobSettings)
        print (json.dumps(job, default=str))

    except Exception as e:
        print ('Exception: %s' % e)
        statusCode = 500
        raise

    finally:
        return {
            'statusCode': statusCode,
            'body': json.dumps(body),
            'headers': {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'}
        }
