# AWSCLI

## Minimal AWS CLI Image for CI Runners and Local Aliases

Ideal image for executing AWS CLI commands from docker-based CI runners

## Supported tags and `Dockerfile` links

- [`latest` _(Dockerfile)_](https://github.com/robpco/docker-awscli/blob/master/Dockerfile)

GitHub Repo: [https://github.com/robpco/docker-awscli](https://github.com/robpco/docker-awscli)

Docker Hub Image: [https://hub.docker.com/r/robpco/docker-awscli/](https://hub.docker.com/r/robpco/awscli/)

## CI SERVER USAGE

- Dramatically faster than base image with AWSCLI installed during each pipeline run
- Small size enables downloading in a fraction of the time of base images
- Doesn't require pip installation of the CLI and dependancies on each run
- Includes `bash` support for bash-specific CI scripts or commands

When using with CI runners, set Image Entrypoint as shown below as default Entrypoint is `aws`.

Example `.gitlab-ci.yml` (GitLab CI) that uses AWS CLI to copy `settings` folder to S3.  (In this example, AWS Credentials are passed via environment variables set as Gitlab Secrets.)

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

For local use create alias .bashrc that passes credentials:

``` bash
# Share "~/.aws" credential and configuration directory
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
