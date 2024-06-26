#!/usr/bin/env bash

# *****************************************
#
#      LineageOS Builder - Sync Script
#
# *****************************************
#
# For Ubuntu 20.04 Only

repo=${LINEAGEOS_REPO:-https://github.com/LineageOS/android.git}
repo_branch=${LINEAGEOS_BRANCH}

. ~/.profile

# 0x00. Sync Android source code
ROOT_PATH=$HOME/android
mkdir -p $ROOT_PATH
cd $ROOT_PATH

repo init -u $repo `[[ $repo_branch ]] && echo "-b $repo_branch"` --git-lfs
repo sync -c -j$(nproc --all) --force-sync --no-tags

# 0x01. Clone custom device tree
device_tree="${DEVICE_TREE}"
device_tree_common="${DEVICE_TREE_COMMON}"
device_tree_vendor="${DEVICE_TREE_VENDOR}"
device_tree_hardware="${DEVICE_TREE_HARDWARE}"
device_tree_repo="${DEVICE_TREE_REPO}"

device_tree_common_repo="${DEVICE_TREE_COMMON_REPO}"
device_tree_vendor_repo="${DEVICE_TREE_VENDOR_REPO}"
device_tree_hardware_repo="${DEVICE_TREE_HARDWARE_REPO}"

# TODO: TBD
