
# PFE - Apolline-k8s

## Hugo Alder - Antoine Lafrance


### Présentation

Ce projet a pour but de déployer automatiquement les services associés à l'analyse des données récupérées par des capteurs de détection de la qualité de l'air dans le cadre du projet Apolline de l'Inria sur un cluster Kubernetes.

### Installation

Pour commencer, il est nécessaire de disposer d'au moins 3 machines Ubuntu accessibles en tant que root afin de pouvoir monter le cluster Kubernetes gràce aux commande suivantes. Il faut dans un premier temps configurer chaque machine, puis configurer le cluster.

Assurez-vous que chaque machine dispose bien d'un hostname différent.

#### Configuration des machines

Pour configurer la machine qui servira de nœud maître, lancer le script `master_node_conf.sh`contenu dans le répertoire `configuration` de ce projet dans le répertoire home du nœud maître.

En lançant le script précédant, vous allez obetnir un affichage indiquant `You can now join any number of machines on running the following on each node as root` suivi d'une commande.

Pour configurer les machines esclaves du cluster, lancer le script `slave_node_conf.sh`contenu dans le répertoire `configuration` de ce projet dans le répertoire home de chaque machine esclave. Une fois cela fait, lancer la commande indiquée lors de la configuration du noeud maître pour rejoindre le cluster Kubernetes.

#### Installation de Helm/Tiller

Une fois que tous les noeuds du cluster sont configurés, installer Helm.

Helm est un gestionnaire de paquets pour Kubernetes. Pour l'installer, lancer depuis le répertoire home de ce projet le script `helm_conf.sh` contenu dans le répertoire `configuration` depuis le noeud maître.

#### Installation des services Kubernetes

Pour déployer l'ensemble des services disponibles en une seule ligne de commande grâce à une chart Helm personnalisée, lancer la commande `helm install --name my-release-name --set global.host="mon-host.fr" appoline-k8s/` depuis le noeud maître.

Le daemonset Traefik fait office d'ingress-controller.
Le service Grafana devrait être accessible à l'adresse mon-host.fr/grafana. 
Le service FROST devrait être accessible à l'adresse mon-host.fr/frost

#### Suppression des services

Pour supprimer l'ensemble des services déployés, lancer la commande `helm delete --purge my-release-name` depuis le noeud maître.

