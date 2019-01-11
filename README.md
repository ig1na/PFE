# PFE - Apolline-k8s
## Hugo Alder - Antoine Lafrance

### Commands

####Install Helm/Tiller in order to use charts:

`curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh`\
`chmod 700 get_helm.sh`\
`./get_helm.sh`

`helm --init tiller-namespace appoline-k8s`

##### Install Traefik as daemon-set mode:
`kubectl apply -f traefik-rbac.yaml`\
`kubectl apply -f traefik-ds.yaml`\
`kubectl apply -f traefik-ingress.yaml`

##### Install Grafana with custom values in .yaml file:
SensorThings plugin is automatically installed.\
`helm install --name grafana-release -f ./grafana-chart/grafana-config.yaml stable/grafana`

##### Install Frost-server:
If helm repo isn't already declared\
`helm repo add fraunhoferiosb https://fraunhoferiosb.github.io/helm-charts/`\
`helm repo update fraunhoferiosb`

Then install frost with custom values in .yaml file\
`helm install --name frost-release -f ./frost-chart/frost-config.yaml fraunhoferiosb/frost-server`

##### Removes helm release:
`helm del --purge release-name`

##### Kubectl helpers (bash inside pod):
`kub exec -it POD-NAME -- /bin/bash`

