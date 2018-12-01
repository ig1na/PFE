# PFE - Apolline-k8s
## Hugo Alder - Antoine Lafrance

### Commands

##### Install grafana with custom values in .yaml file
`helm install --name grafana-release -f grafana-values.yaml stable/grafana`

##### Install frost-server

If helm repo isn't already declared\
`helm repo add fraunhoferiosb https://fraunhoferiosb.github.io/helm-charts/`\
`helm repo update fraunhoferiosb`

Then install frost with custom values in .yaml file\
`helm install --name frost-release -f frost-values.yaml fraunhoferiosb/frost-server`

##### Removes helm release
`helm del --purge release-name`

##### kubectl helpers
`kub exec -it POD-NAME -- /bin/bash`
