#!/bin/bash

virtualenv -q -p /usr/bin/python3 $1
source $1/bin/activate
$1/bin/pip install -r requirements.txt

python3 main.py