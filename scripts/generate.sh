#!/usr/bin/env bash
set -euo pipefail

# List of available GitLab CI variables: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html

cat <<EOF
{
  "buildDefinition": {
   "buildType": "https://gitlab.com/lucarval/sign-attest-poc",
   "resolvedDependencies": [
    {
     "uri": "${CI_PROJECT_URL}",
     "digest": {
      "gitCommit": "${CI_COMMIT_SHA}"
     }
    }
   ]
  },
  "runDetails": {
   "builder": {
    "id": "${CI_RUNNER_ID}",
    "version": {
     "gitlab-runner": "${CI_RUNNER_REVISION}"
    }
   },
   "metadata": {
    "invocationID": "${CI_PIPELINE_ID}",
    "startedOn": "${CI_PIPELINE_CREATED_AT}",
    "finishedOn": "${CI_PIPELINE_CREATED_AT}"
   }
  }
}
EOF
