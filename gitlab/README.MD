
#Installing Gitlab using docker-compose
https://docs.gitlab.com/ee/install/docker.html


#Fixing VM count issue with elastic search on sonarqube
#https://stackoverflow.com/questions/51445846/elasticsearch-max-virtual-memory-areas-vm-max-map-count-65530-is-too-low-inc





Runner
Install Gitlab runner: https://docs.gitlab.com/runner/install/linux-repository.html
#Give runner rights to run docker 
sudo usermod -aG docker gitlab-runner

Register Runner on Gitlab
https://docs.gitlab.com/runner/register/index.html

#Remember to set Pipeline variables

#Install Argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#Get your Password 
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d