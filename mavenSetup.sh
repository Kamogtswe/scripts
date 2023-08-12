#!/bin/bash

echo "Attempting to update packages"
sudo apt update && sudo apt upgrade -y

echo "Checking if Maven is installed"
if ! command -v mvn &> /dev/null; then
    echo "Maven not found, installing"
    mkdir -p /usr/local/apache-maven/apache-maven-3.8.4
    tar -xvf apache-maven-3.8.4-bin.tar.gz -C /usr/local/apache-maven/apache-maven-3.8.4
    echo "export M2_HOME=\"/usr/local/apache-maven/apache-maven-3.8.4\"" >> ~/.bashrc
    echo "export M2=\"$M2_HOME/bin\"" >> ~/.bashrc
    echo "export MAVEN_OPTS=\"-Xms256m -Xmx512m\"" >> ~/.bashrc
    echo "export PATH=\"$M2:$PATH\"" >> ~/.bashrc
    source ~/.bashrc
else
    echo "Maven is already installed"
fi

echo "Maven successfully installed"
mvn -version
