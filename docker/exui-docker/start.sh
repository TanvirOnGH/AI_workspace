#!/bin/bash

# Start the server
conda run --no-capture-output -n exui python3 server.py "$@"
