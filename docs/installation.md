# Project Environment & Installation

Our project is based on **`Carla 0.9.14`** version, so other components are based on Carla's system requirements. You can check informatoins about Carla 0.9.14 installation and requirements at [this link](https://carla.readthedocs.io/en/0.9.14/start_quickstart/).


# OS: Ubuntu 20.04 focal
```shell
# Carla's official supported platform is 18.04, but it was EOL at May 31 2023. So we've chosen 20.04 instead of.
```


# Python: 3.8
```shell
# Carla library is compatiable with Python 2.7, 3.6, 3.7, and 3.8.
```

## Install Python

I've installed python by ppa.
```shell
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.8 python3-pip
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

If your pip is still old version after update, your new pip is in `~/.local/bin/`. So update $PATH or override pip command by alias.

## Install Python Libraries and venv

If your OS and Python is ready to go, you need to install numpy and pygame to use Carla Client.

```shell
# If pip doesn't work, first try pip3. Still not working? Check did you installed pip correctly.
pip install numpy pygame
sudo apt install python3-venv
```


# Carla: 0.9.14

## Install Carla

### 1. Tips
There are two way of installing Carla. First is by Debian package, second is downloading it from github. In this document, I wrote the second way only. Move to [carla's installation document](https://carla.readthedocs.io/en/0.9.14/start_quickstart/#carla-installation) to check the Debian package way.
### 2. Downloading & Unzip
Move to this **[link](https://github.com/carla-simulator/carla/releases/tag/0.9.14/)** and download Carla compressed file and Additional Maps too. The Carla package is 7.8Gb and 6.2Gb to Additional Maps, so let your environment have good network conditions.
### 3. Env setting
After download, move them to certain location and unzip. Remember where did you cloned and unziped, and put the location at variable `CARLA` of [`env.template`](/settings/env.template).
### 4. Import AdditionalAssets
- Linux  
    move the package to the Import folder and run the following script to extract the contents:
    ```shell
    cd path/to/carla/root
    ./ImportAssets.sh
    ```
- Windows  
    Extract the contents directly in the root folder

## Error solve

<img src="./assets/carla-error/situation.png">

If your Carla is too bright and blue, this command will help. Don't forget to put this line in your rc file. `ex: zshrc`
```
export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/nvidia_icd.json"
```

## Install Carla Client Library

Several ways to install carla library was introduced in [official document](https://carla.readthedocs.io/en/0.9.14/start_quickstart/#carla-installation). But installing by whl and egg didn't worked, so I used venv and pip way.

```shell
# This script create and call .env, create venv and install libraries for carla.
./init.sh
```


# ROS Bridge Installation

You can see full document [here](https://carla.readthedocs.io/projects/ros-bridge/en/latest/ros_installation_ros2/).

## Prerequisite
- (ROS2 Foxy)[https://docs.ros.org/en/foxy/Installation.html]
- Additional ROS packages(ex: rviz)
- CARLA 0.9.11 or later (We already have done! 😄)

### ROS2 Foxy
Follow this documentation. [Link](https://docs.ros.org/en/foxy/Installation/Alternatives/Ubuntu-Development-Setup.html)

1. Locale setting
```shell
locale  # check for UTF-8

sudo apt update && sudo apt install locales

sudo locale-gen en_US en_US.UTF-8

sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

locale  # verify settings
```

2. Add ROS2 repository
```shell
sudo apt install software-properties-common

sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

3. Install development tools and ROS tools
```shell
sudo apt update && sudo apt install -y \
  libbullet-dev \
  python3-pip \
  python3-pytest-cov \
  ros-dev-tools

# install some pip packages needed for testing
python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest

# install Fast-RTPS dependencies
sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev

# install Cyclone DDS dependencies
sudo apt install --no-install-recommends -y \
  libcunit1-dev
```

4. Get ROS2 Code
```shell
mkdir -p ~/ros2_foxy/src

cd ~/ros2_foxy

vcs import --input https://raw.githubusercontent.com/ros2/ros2/foxy/ros2.repos src
```

5. Install dependencies using rosdep
```shell
sudo apt upgrade

sudo rosdep init

rosdep update

rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-5.3.1 urdfdom_headers"

colcon build --symlink-install
```

### RVIZ2 install
```
sudo apt install ros-foxy-rviz2
```

## Install ROS Bridge
```shell
mkdir -p ~/carla-ros-bridge && cd ~/carla-ros-bridge

git clone --recurse-submodules https://github.com/carla-simulator/ros-bridge.git src/ros-bridge

source /opt/ros/foxy/setup.zsh

sudo apt install ros-foxy-pcl-conversions

rosdep update

rosdep install --from-paths src --ignore-src -r

colcon build
```

## Run ROS Bridge

1. Run your Carla.
```shell
carla 
```

2. Add the correct CARLA modules to your Python path
```shell
export CARLA_ROOT=<path-to-carla>

export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-<carla_version_and_arch>.egg:$CARLA_ROOT/PythonAPI/carla
```
Don't forget to put this to your rc file. `ex: zshrc`

3. Add the source path for the ROS bridge workspace
```shell
ros-init # custom alias command
```