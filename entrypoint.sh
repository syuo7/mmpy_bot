#!/bin/bash

giddyup health &
python /home/app/run.py

exec "$@"

