# Downloading Helm/Tiller
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh\
chmod 700 get_helm.sh\

# Creating clusterrole for Helm
kubectl create -f ./configuration/rbac-config.yaml

# Install Helm/Tiller
./get_helm.sh
helm init --service-account tiller

