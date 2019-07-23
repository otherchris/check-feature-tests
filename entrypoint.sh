#! /bin/bash

BRANCH=$(cat /github/workflow/event.json | jq -r ".pull_request.base.ref")
MSG=$(git log -1 --oneline)
ACTION=$(cat /github/workflow/event.json | jq -r ".action")
LAST_GOOD=$(cat last_valid_sha)

if [[ $BRANCH =~ "release" ]]; then
  if [[ $MSG =~ "feature test passed" ]]; then
      exit 0
  fi
  echo "Feature tests not checked on this sha, do \"make run_feature_tests\" and recommit."
  exit 1
fi

exit 78
