#!/bin/sh
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin
find ~/code_projects -type d -maxdepth 5 -name 'node_modules' -prune | tee tmutil addexclusion > ~/.cron/$(date +%Y%m%d)_excluded-node_modules.log
find ~/code_projects -type d -maxdepth 5 -name '.git' | tee tmutil addexclusion > ~/.cron/$(date +%Y%m%d)_excluded-git.log
find ~/code_projects -type d -maxdepth 5 -name 'tmp' | tee tmutil addexclusion > ~/.cron/$(date +%Y%m%d)_excluded-tmp.log
find ~/code_projects -type d -maxdepth 5 -name 'target' | tee tmutil addexclusion > ~/.cron/$(date +%Y%m%d)_excluded-target.log
find ~/code_projects -type d -maxdepth 5 -name '.venv' | tee tmutil addexclusion > ~/.cron/$(date +%Y%m%d)_excluded-venv.log
