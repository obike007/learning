#CLIENT SIDE 
https://github.com/jkroepke/helm-secrets


#Install SOPS
curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64
mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops
chmod +x /usr/local/bin/sops

#Install helm secrets plugin
helm plugin install https://github.com/jkroepke/helm-secrets --version v4.6.0


#Generate Key pair using gpg
gpg --gen-key

#Check if Key was Created
gpg --list-key

90D14859E15272800B3B690D71F0BC9A26C8D2E1
#Create and Encrpt Secret 
sops -p 90D14859E15272800B3B690D71F0BC9A26C8D2E1 secrets.yaml

#Test secret decryption
helm secrets decrypt secrets.yaml 

#Install Application with encrypted secrets
helm secrets install app ./app -n default -f ./secrets.yaml

