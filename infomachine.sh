#!/bin/bash

# Fonction pour afficher une section du script
print_section() {
    echo "--------------------------------------------------"
    echo "$1"
    echo "--------------------------------------------------"
    echo
}

##############
# Informations système
##############

print_section "Informations système"

# Récupérer le nom de la machine
machine_name=$(hostname)
echo "Nom de la machine : $machine_name"

# Récupérer le nom du système d'exploitation et sa version
os_name=$(lsb_release -ds)
echo "Système d'exploitation : $os_name"

# Récupérer la version du noyau
kernel_version=$(uname -r)
echo "Version du noyau : $kernel_version"

# Récupérer l'uptime de la machine
uptime=$(uptime -p)
echo "Uptime de la machine : $uptime"

# Récupérer le nombre d'utilisateurs système
system_users=$(grep -c '^[^:]*:[^:]*:[0-9]\{4\}' /etc/passwd)
echo "Nombre d'utilisateurs système : $system_users"

# Récupérer le nombre d'utilisateurs humains
human_users=$(grep -c '^[^:]*:[^:]*:[1-9]' /etc/passwd)
echo "Nombre d'utilisateurs humains : $human_users"

# Récupérer les utilisateurs connectés à la machine
connected_users=$(who | awk '{print $1}')
echo "Utilisateurs connectés à la machine :"
echo "$connected_users"

##############
# Cartes réseau
##############

print_section "Cartes réseau"

# Récupérer le nombre de cartes réseau
network_cards=$(ls /sys/class/net/ | wc -l)
echo "Nombre de cartes réseau : $network_cards"

# Récupérer les adresses IPv4 des cartes réseau
ipv4_addresses=$(ip -4 addr | awk '/inet /{print $2}')
echo "Adresses IPv4 des cartes réseau :"
echo "$ipv4_addresses"

# Récupérer les adresses IPv6 des cartes réseau
ipv6_addresses=$(ip -6 addr | awk '/inet6/{print $2}')
echo "Adresses IPv6 des cartes réseau :"
echo "$ipv6_addresses"

##############
# Ports ouverts
##############

print_section "Ports ouverts"

# Exécuter nmap pour obtenir les informations sur les ports ouverts, la liste des ports ouverts et les informations sur les services associés
nmap_output=$(sudo nmap -p- --open -T4 -sV 127.0.0.1)

# Récupérer le nombre de ports ouverts sur la machine
open_ports_count=$(echo "$nmap_output" | grep -E '^[0-9]+/' | wc -l)
echo "Nombre de ports ouverts : $open_ports_count"

# Récupérer la liste des ports ouverts sur la machine
open_ports_list=$(echo "$nmap_output" | grep -E '^[0-9]+/' | awk -F'/' '{print $1}')
echo "Liste des ports ouverts :"
echo "$open_ports_list"

# Récupérer la version et le nom du service réseau qui ouvre ses ports
service_info=$(echo "$nmap_output" | awk '/\/(

tcp|udp)/ {printf $1" "$2" "$3; for(i=4; i<=NF; i++) printf $i" "; print ""}')
echo "Version et nom du service réseau :"
echo "$service_info"
```

Ce nouveau format utilise des sections clairement délimitées et des titres pour chaque partie du script, facilitant ainsi la compréhension et la lecture lors de l'exécution.
