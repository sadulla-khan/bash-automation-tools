#CLI Cheatsheet for Linux and Cyber Security
central reference for commands, tools and scripts I use frequently.

---
#System and Package Management

sudo apt update && sudo apt upgrade -y          #update system
sudo apt install <package>                      #install package
dpkg -l                                         #list all packages installed
dpkg -i <package>.deb                           #install downloaded package
dpkg -r <package>                               #removes package leaves config
dpkg -p <package>                               #removes package with config
dpkg -s <package>                               #display package version, description,  dependency, architechture 

#Files and Directories


