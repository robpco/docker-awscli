# AWSCLI

## Minimal AWS CLI Image for CI Runners and Local Alias Use

### Supported tags and `Dockerfile` links

- [`latest` _(Dockerfile)_](https://github.com/robpco/docker-awscli/blob/master/Dockerfile)

GitHub Repo: [https://github.com/robpco/docker-awscli](https://github.com/robpco/docker-awscli)

Docker Hub Image: [https://hub.docker.com/r/robpco/awscli/](https://hub.docker.com/r/robpco/awscli/)

## CI SERVER USAGE

Image created to enable CI runners to execute AWS CLI commands

- Dramatically faster than downloading base image and installing AWS CLI for each execution
- Downloads fast due to small size (33 MB compressed)
- Executes fast as AWS CLI and dependancies are preinstalled
- Includes `bash`, `curl` and `git` commands for use in CI scripts

**Example `.gitlab-ci.yml` (GitLab CI)** using image to copy directory to S3

- Set Entrypoint to override default of `aws`
- Pass AWS Credentials via environment variables set as CI Secrets

``` yaml
image:
  name: robpco/awscli
  entrypoint:
    - '/usr/bin/env'
    - 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

deploy:
  script:
  - aws s3 sync --no-progress --region "$BUCKET_REGION" "./settings" "$BUCKET_BASE/settings"
```

## ALIAS USAGE

For CLI use create an alias .bashrc that passes credentials using one of the methods below

``` bash
# Example alias that shares local host "~/.aws" directory
alias aws='docker run --rm -t -v ~/.aws:/root/.aws:ro $(tty &>/dev/null && echo "-i") robpco/awscli'
```

### Passing Credentials

``` bash
# Share .aws credential and configuration directories:
docker run --rm -v <config_path>:/root/.aws:ro \
                -v <option_yml>:/aws:ro \
                      robpco/awscli <argument>

# Share Credentials via Environment Variables:
docker run --rm -it -e AWS_ACCESS_KEY_ID \
                    -e AWS_SECRET_ACCESS_KEY \
                    -e AWS_DEFAULT_REGION \
                      robpco/awscli <argument>

# Explicitly Define Credentials:
docker run --rm -e AWS_ACCESS_KEY_ID=<key> \
                -e AWS_SECRET_ACCESS_KEY=<secret> \
                -e AWS_DEFAULT_REGION=<region> \
                -v <option_yml>:/aws:ro \
                      robpco/awscli <argument>

```
