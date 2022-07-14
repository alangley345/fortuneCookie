
# Fortune Cookie Web App
================================================

## My intention is to complete the following parts of this project:

* Angular frontend hosted in S3 (leaning towards exposing this with Cloudflare)
* Nodejs/Express backend hosted on EBS (maybe a container)
* AWS SES to email fortunes out
* MongoDB Atlas hosted db

## Methods
* Connect the DB to the Backend using an IAM role integration.
* Define resources using Terraform
* Github Actions and shell to glue everything together.
* Send logs to either Cloud Watch or New Relic

## Necessary API Calls
* Get a new fortune from DB
* Get all fortunes in DB
* Add fortune to DB
* Add user to allow authentication to add fortune
* Enable subscriptions



