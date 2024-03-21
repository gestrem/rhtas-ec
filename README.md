# Sign Attest Proof of Concept

This repository demonstrates how to use cosign to sign and attest container images built in a
GitLab pipeline.

The [.gitlab-ci.yml](.gitlab-ci.yml) defines the `secure` stage which is responsible for signing
the built container image, generating a SLSA Provenance 1.0 predicate, and attesting the image.

NOTE: The process described here relies on self-generated provenance information.

## Verify the Image

There are different ways to verify the image is properly signed and attested. Use `cosign` to peform
a simple signature check on the image and its attestation:

```text
IMAGE=registry.gitlab.com/lucarval/sign-attest-poc:latest

cosign verify $IMAGE \
    --certificate-identity='https://gitlab.com/lucarval/sign-attest-poc//.gitlab-ci.yml@refs/heads/main' \
    --certificate-oidc-issuer='https://gitlab.com'

cosign verify-attestation --type https://slsa.dev/provenance/v1 $IMAGE \
    --certificate-identity='https://gitlab.com/lucarval/sign-attest-poc//.gitlab-ci.yml@refs/heads/main' \
    --certificate-oidc-issuer='https://gitlab.com'
```

For advanced checks, use the [Enterprise Contract](https://enterprisecontract.dev) CLI tool. To get
started, create a basic `policy.yaml` configuration file:

```yaml
---
identity:
  subject: https://gitlab.com/lucarval/sign-attest-poc//.gitlab-ci.yml@refs/heads/main
  issuer: https://gitlab.com
```

Then verify the image meets the policy requirements:

```text
IMAGE=registry.gitlab.com/lucarval/sign-attest-poc:latest

ec validate image --policy policy.yaml --image $IMAGE
```

To take this a step further, verify the SLSA Provenance contains the expected content. For this, use
the policy rules defined in
[simple-ec-policies-gitlab](https://gitlab.com/lucarval/simple-ec-policies).

Modify `policy.yaml` to include those policies:

```yaml
---
identity:
  subject: https://gitlab.com/lucarval/sign-attest-poc//.gitlab-ci.yml@refs/heads/main
  issuer: https://gitlab.com
sources:
  - policy:
    - git::https://gitlab.com/lucarval/simple-ec-policies
```

Next, create `images.json` to define the expected git source information:

```yaml
---
components:
  - containerImage: registry.gitlab.com/lucarval/sign-attest-poc@sha256:b02b804c9a49d85145c3f4a57968ec8a3e737bea1059450f990d26548fb8719b
    source:
      git:
        url: https://gitlab.com/lucarval/sign-attest-poc
        revision: 4dd3077cda15a53d0df84659fcd1904beb005adf
```

Finally, run verify the images comply to the new policy:

```text
ec validate image --policy policy.yaml --images images.yaml
```
