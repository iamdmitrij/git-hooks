#!/bin/sh
#
# A hook script to prepare the commit log message.
# If the branch name is a JIRA ticket.
# It adds the branch name to the commit message, if it is not already part of it.
# If branch named not according to regexp pattern TEXT-NUMBER it will prepare original commit message.
NAME=$(git branch --show-current | grep '[A-Z][A-Z0-9]*\-[0-9][0-9]*' | sed 's/* //')
DESCRIPTION=$(git config branch."$NAME".description)
# Skip if pattern is not found
if [[ $NAME == '' ]]; then
    exit
fi
# Message already contains ticket
if [[ $1 == $NAME* ]]; then
    exit
fi
echo "$NAME"': '$(cat "$1") >"$1"
if [ -n "$DESCRIPTION" ]; then
    echo "" >>"$1"
    echo $DESCRIPTION >>"$1"
fi