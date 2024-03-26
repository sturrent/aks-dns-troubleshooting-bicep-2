# aks-dns-troubleshooting-bicep-2

This repository provides a bicep template to deploy an AKS cluster scenario for DNS performance troubleshoting.

Clone the repo, go to the directory, and run:

```az deployment sub create --name <DEPLOYMENT_NAME> -l <LOCATION> --template-file main.bicep```

Note: Currently all files are referencing southcentralus location, but it can be change using params.
