### Terraform Deployment to EKS kubernetes cluster with reusable deployment module
How to use
1. Run terraform init and apply in root - THIS WILL TAKE ABOUT 10 MINUTES
    You now have your Kubernetes cluster made.  This has output variables that the modules will call into
    If you want to run kubectl commands make sure you have kubectl and the aws cli installed and then run this command to grab your kubeconfig:
        aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
        ![Getting your kubeconfig](https://github.com/kjblanchard/terraformHelmk8sDeploy/raw/master/content/getkctl.gif "Getting your Kubeconfig")
2. Move into the deployment folder and run terraform init and apply, you can now view your pods and metrics with kubectl commands.
        ![Getting your kubeconfig](https://github.com/kjblanchard/terraformHelmk8sDeploy/raw/master/content/viewpods.gif "View your pods")
3. You now have your deployment.  You can change the input values for the module if the image name changes when you update it in the build.  You can also view it by navigating to the ELBs address.  You can get the elb address by running the command "kubectl get svc" and then grabbing the service name in it.
        ![Get the service](https://github.com/kjblanchard/terraformHelmk8sDeploy/raw/master/content/getelb.gif "Get the service name")
        ![Changing the variables](https://github.com/kjblanchard/terraformHelmk8sDeploy/raw/master/content/changedeployment.gif "Modify your deployment")
4. Run terraform destroy in the deployQuoteGen folder to destroy the deployment
5. Run terraform destroy in the root folder to destroy the EKS cluster

### Notes
- The In a real world scenario we would be using Jenkins to build with proper versioning and such, and potentially after building run a terraform deployment into the other folder if we wanted automatic deployments, otherwise stick with manual deployments
- I decided to use EKS instead of ECS as I wanted to get some experience using helm charts in kubernetes in terraform, I also wanted to try to deploy jenkins with a helm chart, but in the short time period for this I decided to cancel it as it was time consuming for configuration as code for the jenkins server.
- I used local state for the root module just so that we could skip a init/apply for building the remote backend.

### Task list
- This is complete - Github webhook action - on changes send out to jenkins
- This is complete - Create EKS in a root module so that it is separate from the deployments
- This is complete - A module that we can reuse for deployoments
- This is complete - A implementation of the module for the deployment
- This is complete - Variable to automatically set a r53 record of mine so that it updates the dns entry

- Cancelled - Building images in Jenkins in kubernetes - Too time consuming for this project to setup infra-as-code to setup the pipeline dynamically, so using github action instead to build things with less cool factor