# Supported tags and `Dockerfile` links

## minimal size aws-cli image for desktop or CI use

Minimal AWS CLI Image for CI Server and Alias Use

## AWSCLI

- [`latest` _(Dockerfile)_](https://github.com/robpco/docker-awscli/blob/976b72d54365fc366bfa345eec8c2c18de65634d/Dockerfile)

## CI SERVER USAGE

This image is ideal for execution AWS CLI commands on docker-based CI runners.  It downloads quickly and doesn't require any preparation steps to use.  Making it much quicker than downloading a Python / Ubuntu base image then running `pip install awscli`

Make sure to set the Entrypoint to `bash` as the image default Entrypoint is `aws`.

Example `.gitlab-ci.yml` (GitLab CI) file with entrypoint setting:

``` bash
image:
  name: robpco/awscli
  entrypoint:
    - '/bin/bash'

deploy:
  script:
  - aws s3 sync --exact-timestamps --no-progress --region "$BUCKET_REGION" "./settings" "$BUCKET_BASE/settings"
```

## ALIAS USAGE

For local machine use, create an alias in in your .bashrc that passes your credentials:

``` bash
# example passing "~/.aws" configuration directory
alias aws='docker run --rm -t -v ~/.aws:/root/.aws:ro $(tty &>/dev/null && echo "-i") robpco/awscli'
```

### Passing Credentials

Share .aws credentials and configuration:
`docker run --rm -v <config_path>:/root/.aws:ro -v <option_yml>:/aws:ro robpco/awscli <argument>`

Share Credential via Environment Variables:
`docker run --rm -it -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION robpco/awscli <argument>`

Explicitly Define Credentials:
`docker run --rm -e AWS_ACCESS_KEY_ID=<key> -e AWS_SECRET_ACCESS_KEY=<secret> -e AWS_DEFAULT_REGION=<region> -v <option_yml>:/aws:ro robpco/awscli <argument>`
