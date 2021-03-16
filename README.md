# Vault Minikube Demo
A demo of how one can achieve multiple intermediate CAs on Vault PKI secrets engines split across multiple Vault Namespaces, and how these can issue certificates to a vault client nginx container running on Kubernetes (Minikube)

## Software Requirements
This demo was tested using the following software:
Minikube
```
$ minikube version
minikube version: v1.18.1
commit: 09ee84d530de4a92f00f1c5dbc34cead092b95bc
```
HashiCorp Vault 1.6.2
```
$ vault version
Vault v1.6.2
```
Helm 3.4.1:
```
$ helm version
version.BuildInfo{Version:"v3.4.1", GitCommit:"c4e74854886b2efe3321e185578e6db9be0a6e29", GitTreeState:"dirty", GoVersion:"go1.15.4"}
```
MacOS Big Sur 11.2.3
```
$sw_vers
ProductName:    macOS
ProductVersion: 11.2.3
BuildVersion:   20D91
```

It may be possible to implement the demo with other versions of the above software, but this is neither tested
or guaranteed.

## Pre-Steps:
1. Install Minikube
1. Install HashiCorp Vault
1. Install Helm
1. Start Minikube using the `minikube start` command.
1. Identify the ip address of your Minikube server and plant it into a file within the root of your working directory using the following command:
`$ echo $(minikube ip) > my_ip.txt`
1. Add in your local IP address into a file called `my_ip.txt`
1. Run each of the scripts in order starting from 0-... through to 4-...
1. Once scripts have run and pods deployed into vault-demo project are ready, access the following address
in your web browser `http://$(minikube ip):32080`.
1. Observe the output in your web browser.
1. When you are ready to kill the demo, run `99-kill-vault.sh` to kill the Vault dev server. Then simply run `minikube stop` or `minikube delete` to stop or delete the minikube deployment. 

### Caveats to this approach

* This approach utilises Vault Agent for encryption of ciphertext. This approach has some major flaws, and is simply provided here as a proof-of-concept. The flaws to this approach include:
1. Plaintext is stored in the YAML annotations, defeating the object of encrypting it.
1. Ciphertext cannot be easily updated without running a redeployment of your Kubernetes YAML with updated annotations.

### More Optimal Approach

The optimal approach to overcome this problem is to instead make your application "Vault Aware" to an extent, whereby it can use the Vault Agent running in the pod as a proxy, handling authentication to Vault on its behalf. An example of how this can be performed for a Golang app can be found [on Jason O'Donnell's Vault Agent Demo](https://github.com/jasonodonnell/vault-agent-demo/blob/master/src/transit/main.go)

## Warning
This demo is provided as-is with no support or guarantee. It makes no claim as to "production-readiness" in areas including but not limited to:
- Configuration of Vault (including unsealing and configuring Vault, configuration of Transit secrets engine and so on)
- Configuration of Kubernetes
- Deployment of applications onto Kubernetes