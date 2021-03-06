#!/bin/sh

@[if DEVELSPACE]@
export THOR_SCRIPTS=@(PROJECT_SOURCE_DIR)/scripts
@[else]@
export THOR_SCRIPTS=@(CMAKE_INSTALL_PREFIX)/@(CATKIN_PACKAGE_SHARE_DESTINATION)/scripts
@[end if]@
export THOR_ROOT=$(cd "@(CMAKE_SOURCE_DIR)/.."; pwd)

# set THOR_* environment variables
alias l_vt_hand='. l_vt_hand'
alias r_vt_hand='. r_vt_hand'
alias l_thor_mang_hand='. l_thor_mang_hand'
alias r_thor_mang_hand='. r_thor_mang_hand'

# include THOR_scripts hooks
#if [ -d $THOR_SCRIPTS ]; then
#  . $THOR_SCRIPTS/functions.sh
#  . $THOR_SCRIPTS/robot.sh ""

#  _THOR_include "$THOR_SCRIPTS/setup.d/*.sh"
#  _THOR_include "$THOR_SCRIPTS/$HOSTNAME/setup.d/*.sh"

#  if [ -r "$THOR_SCRIPTS/$HOSTNAME/setup.sh" ]; then
#      echo "Including $THOR_SCRIPTS/$HOSTNAME/setup.sh..." >&2
#      . "$THOR_SCRIPTS/$HOSTNAME/setup.sh"
#  fi
#fi

# export additional ROS_PACKAGE_PATH for indigo
if [ "$ROS_DISTRO" = "indigo" ]; then
    export ROS_BOOST_LIB_DIR_NAME=/usr/lib/x86_64-linux-gnu
    export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$ROS_WORKSPACE/../external
fi

# export some variables
export PATH=$THOR_SCRIPTS/helper:$PATH
export ROS_WORKSPACE=$THOR_ROOT/src
export THOR_MOTION_HOSTNAME="thor-motion"
export THOR_PERCEPTION_HOSTNAME="thor-perception"
export ROBOT_HOSTNAMES="thor-motion thor-perception"
export ROBOT_USER="thor"
export LEFT_HAND_TYPE="l_vt_hand"
export RIGHT_HAND_TYPE="r_vt_hand"

# adding ssh keys
if [ -d "$THOR_ROOT/.ssh/" ] && [ "$(ls -A $THOR_ROOT/.ssh/)" ]; then
    #echo "Adding ssh keys from '$THOR_ROOT/.ssh/':"
    for f in $THOR_ROOT/.ssh/*; do
        ssh-add $f
    done
fi
