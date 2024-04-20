#Server Side K8s secret Mgmt

#Installing Kubeseal on linux
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.26.1/kubeseal-0.26.1-linux-amd64.tar.gz

tar -xvzf kubeseal-0.26.1-linux-amd64.tar.gz kubeseal
install -m 755 kubeseal /usr/local/bin/kubeseal

#Installing Sealed Secrets Controller
kubectl apply -f controller.yaml


#Fetch Certificate if you dont have direct access to api server
get the certificate key from the controller logs or 
kubeseal --fetch-cert > cert.pem



#Encrypt Your secret
kubeseal < secret.yaml --scope strict -o yaml > sealedsecret.yaml
#namespace-wide
#cluster-wide

#Check if secret is correct
kubectl get secret my-secret -o yaml
