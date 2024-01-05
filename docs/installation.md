# Project Environment & Installation

Our project is based on **`Carla 0.9.15`** version, so other components are based on Carla's system requirements. You can check informatoins about Carla 0.9.15 installation and requirements at [this link](https://carla.readthedocs.io/en/0.9.15/start_quickstart/).


## OS: Ubuntu 20.04 focal
```shell
# Carla's official supported platform is 18.04, but it was EOL at May 31 2023. So we've chosen 20.04 instead of.
```


## Python: 3.8
```shell
# Carla library is compatiable with Python 2.7, 3.6, 3.7, and 3.8.
```

### Install Python

I've installed python by ppa.
```shell
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.7 pip
```

If you wanna check is python ready, please run this command and check the result.
```shell
> python3 --version
Python 3.8.10

> pip3 --version
pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
```

You need 20.3 or higher for pip to install carla api. So if your pip version is low, run this command:
```
sudo apt upgrade pip
```

### Install Python Libraries and venv

If your OS and Python is ready to go, you need to install numpy and pygame to use Carla Client.

```shell
# If pip doesn't work, first try pip3. Still not working? Check did you installed pip correctly.
pip install numpy pygame
```


## Carla: 0.9.15

### Install Carla

#### 1. Tips
There are two way of installing Carla. First is by Debian package, second is downloading it from github. In this document, I wrote the second way only. Move to [carla's installation document](https://carla.readthedocs.io/en/0.9.15/start_quickstart/#carla-installation) to check the Debian package way.
#### 2. Downloading & Unzip
Move to this **[link](https://github.com/carla-simulator/carla/releases/tag/0.9.15/)** and download Carla compressed file and Additional Maps too. The Carla package is 7.8Gb and 6.2Gb to Additional Maps, so let your environment have good network conditions.
#### 3. Env setting
After download, move them to certain location and unzip. Remember where did you cloned and unziped, and put the location at variable `CARLA` of [`env.template`](/settings/env.template).
#### 4. Import AdditionalAssets
- Linux  
    move the package to the Import folder and run the following script to extract the contents:
    ```shell
    cd path/to/carla/root
    ./ImportAssets.sh
    ```
- Windows  
    Extract the contents directly in the root folder

### Install Carla Client Library

Several ways to install carla library was introduced in [official document](https://carla.readthedocs.io/en/0.9.15/start_quickstart/#carla-installation). But installing by whl and egg didn't worked, so I used venv and pip way.

```shell
# This script create and call .env, create venv and install libraries for carla.
./init.sh
```