#!/bin/bash

trap exit_handler SIGINT

function exit_handler() {
    echo "exiting"
    make archive DB="~/dev/tetrio-metrics/data.db"
}

tetrio-metrics
