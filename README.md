# PFE - Apolline-k8s
## Hugo Alder - Antoine Lafrance

### Ce que nous avons fait

Nous avons commencé par travailler sur minikube et nous y avons deployé grafana et le serveur frost. Conscients des différences qu'il existe entre cette solution locale et un véritable cluster distant, nous avons commencé à faire ces deploiements sur un serveur cloud OVH.

Nous avons eu des difficultés avec le déploiement de grafana notamment avec l'accès via l'url /grafana qui ne fonctionnait pas à cause d'un paramètre de configuration du reverse-proxy.

Nous avons configuré un ingress controller avec un reverse proxy traefik pour éviter d'avoir à passer par les ports et sécuriser l'accès. Si on tente d'accéder à un service qui n'est pas deployé sur le node master, l'accès par le port de ce node n'est pas possible sans ingress controller.

Nous essayons actuellement d'activer la persistence des données car le fait d'avoir des repliques empêche la sauvegarde de session. En effet lorsqu'un client se connecte au service, kubernetes redirige le client sur un pod différent à chaque requête, le pod ne peut donc pas garder la session en mémoire si la persistence des données n'est pas active. Nous pensions qu'en décrivant les paramètres "persistence" dans le values.yaml du chart grafana, la création des volumes se feraient automatiquement mais cela n'est pas le cas. Nous devons d'abord créer des volumes persistants, puis des claims, et nous devons quand même préciser tous les paramètres de la persistence dans le grafana-config.yaml.

La persistence des données est maintenant activée, nous avons pour cela dû créer un dossier directement sur le serveur avec des droits d'écriture pour que kubernetes puisse y créer son persistenceVolume. Nous avons du aussi ajouter un label au paramètre nodeSelector du fichier grafana-config.yaml car nous avions plusieurs nodes sur notre serveur et lors du deploiement kubernetes choisissait un node au hasard.

### Ce qu'il nous reste à faire

Deployer istio sur le cluster et tenter de sécuriser le cluster.\
Pouvoir deployer correctement les différentes parties et faire un scrpit bash qui execute tout en une ligne de commande.\
Etendre la base de données OGC pour matcher celle déjà existante.

### Commands

#### Install Helm/Tiller in order to use charts:

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

