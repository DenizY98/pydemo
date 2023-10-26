# Python Web Server Image
This is a simple project that shows how to build a basic Python web server image using Docker. The image runs a Flask app that returns “Hello, World!” when accessed.

## Prerequisites
To run this project, you need to have the following installed on your machine:

- Docker: You can download and install Docker from [https://docs.docker.com/get-docker/].

If you also want to deploy the App to CF or Kyma from Terminal, then you'll also need:
- Cloud Foundry CLI: You can download and install the Cloud Foundry CLI from [https://github.com/cloudfoundry/cli/wiki/V8-CLI-Installation-Guide#installers-and-compressed-binaries].
- Kyma CLI
### Alternatives for Prerequisites
In case you dont have the permissions for any of the prerequisites mentioned, you can workaround yourself by using a cloud service called Play-with-Docker, but therefore you will need a 
- Account at Docker Hub [https://hub.docker.com]
- Play-with-Docker [http://play-with-docker.com] 
- As alternative to the CLI applications from the runtimes, you could use their GUI
### Build and run the image locally
To build and run the image locally, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the repository folder and run the following command to build the image:
```docker build -t ourdemoapp . ```
3. Run the following command to run the image in a container:
```docker run -p 8080:8080 ourdemoapp```
4. Open your browser and go to http://localhost:8080 to see the app running.

### Push the image to Docker Hub
To push the image to Docker Hub, follow these steps:

1. Create an account on [Docker Hub] if you don’t have one already.
2. Log in to your Docker Hub account using the following command:
```docker login```
3. Tag your image with your Docker Hub username and a name for your repository, for example:
```docker tag ourdemoapp dockerhubuser/ourdemoapp```
4. Push your image to Docker Hub using the following command:
```docker push dockerhubuser/ourdemoapp```
5. You can now see your image on your Docker Hub profile page.

### Deploy the image to Cloud Foundry
To deploy the image to Cloud Foundry, follow these steps:

1. Log in to your Cloud Foundry account using the following command:
```cf login```
2. Enter the API-Endpoint that you can get from SAP BTP
3. Create a manifest.yml file in the repository folder with the following content:
```yaml
applications:
- name: demoapp
  memory: 128M
  instances: 1
  docker:
    image: dockerhubuser/ourdemoapp
```

Replace dockerhubuser with your Docker Hub username.
Run the following command to deploy the app to Cloud Foundry:
```cf push```
You can now see your app running on Cloud Foundry by using the URL provided by the command output.

### Deploy the image to Kyma Runtime
1. Install Kubectl according to the Installation guide [https://kubernetes.io/de/docs/tasks/tools/]
2. Log into SAP BTP subaccount and download the ```kubeconfig.yaml```
3. Set the environmental variable: 
Powershell:     ```$ENV:KUBECONFIG="/path/to/kubeconfig.yaml"```
Bash:           ```export KUBECONFIG="/path/to/kubeconfig.yaml"```
4. Connect the Kyma CLI to the Kyma cluster using:
```kubectl get namespaces```
5. Create a namespace for you application:
```kubectl create namespace demons```
6. Deploy the application to the namespace using the following command:
```kubectl apply -f deployment.yaml -n demons```
#### To access the deployed application on Kyma, you'll also need a service binding to the App and a API-Rule

You can simply edit the templates and apply them with kubectl:
- py-service.yaml
- py-apirule.yaml

according to your desired naming conventions and
push it to the Kyma cluster with the following commands:

```kubectl apply -f kyma/py-service.yaml -n demons```
```kubectl apply -f kyma/py-apirule.yaml -n demons```

After finished with that steps you should be able to access your application by navigating to:
```http://py-apirule.hostname.kyma.shoot.live.k8s-hana.ondemand.com``` 