# bedrock_image
Bedrock server

![CI](https://github.com/serverless-minecraft/bedrock_image/workflows/CI/badge.svg)

This picks up the image from https://github.com/itzg/docker-minecraft-bedrock-server, adds route53 update and backup/restore, and pushes to an AWS ECR.

Make sure you have AWS secrets configured for the action to work, and the ECR repository created.
