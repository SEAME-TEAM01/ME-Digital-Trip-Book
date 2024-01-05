#!/usr/bin/zsh
# env setting
rm -f .env
cat env.template >> .env
export $(grep -v '^#' .env | xargs -d '\n')

# venv setting
rm -rf venv
# pip install --upgrade pip
# pip3 install --upgrade pip
python3 -m venv $VENV
source $VENV/bin/activate
pip3 install -qU pip
pip3 install -qr requirement.txt
printf "\nrun this command to activate the virtual environment.\n------------------------------------\nsource $VENV/bin/activate\n"
