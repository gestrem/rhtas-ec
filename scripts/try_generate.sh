#!/usr/bin/env bash
set -euo pipefail

CI_COMMIT_SHA='c0ea6e883c574b85853d6681967c363bb3255063' \
CI_PROJECT_URL='https://gitlab.com/lucarval/sign-attest-poc' \
CI_RUNNER_ID='https://gitlab.com/lucarval/image-provenance-poc/-/runners/12270845' \
CI_RUNNER_REVISION='782c6ecb' \
CI_PIPELINE_ID='6354661207' \
CI_PIPELINE_CREATED_AT='2024-03-08T20:21:08Z' \
    ./generate.sh
