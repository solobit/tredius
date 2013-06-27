#!/usr/bin/env bash

awk -f unmangle-literate.awk -v untangle="md" $1
