#!/bin/bash

echo "Attempting to update packages"
sudo apt update && sudo apt upgrade -y

echo "Checking if Java is installed"
if ! command -v java &> /dev/null; then
    echo "Java not found, installing"
    sudo apt-get install openjdk-11-jdk -y
fi

echo "Setting Java variables"
# Set Java Home
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))

# Add Java bin directory to PATH
export PATH=$PATH:$JAVA_HOME/bin

echo "Java variables set"
java -version
