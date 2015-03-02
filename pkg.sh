#!/bin/bash
tar -czf vim-auto-save.tar.gz --exclude='.git*' --exclude='pkg.sh' --exclude='vim-auto-save.tar.gz' .
