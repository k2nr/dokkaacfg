[![Build Status](https://travis-ci.org/k2nr/dokkaacfg.svg?branch=master)](https://travis-ci.org/k2nr/dokkaacfg)

# dokkaacfg

This is a part of [Dokkaa project](https://github.com/k2nr/dokkaa).
dokkaacfg is a CLI tool for Dokkaa cluster management.

## Instalation

```
$ gem install dokkaacfg
```

## Usage

Currently dokkaacfg only supports DigitalOcean.

### Launch dokkaa cluster

```bash
$ export DIGITALOCEAN_ACCESS_TOKEN=<your digitalocean access token>
$ dokkaacfg --provider=digitalocean up --scale=2 --ssh_key=<your ssh key name>
```

The above command creates two Core OS instances on DigitalOcean.
After seconds, you'll see the instances on DigitalOcean Dashboard.

![](https://github.com/k2nr/dokkaacfg/raw/master/doc/images/screenshot_do.png)

On Startup sequence, each instance pull docker images and run by Core OS cloud-config.
See [user-data](https://github.com/k2nr/dokkaacfg/blob/master/user-data).

### Shutdown dokkaa cluster

```bash
$ export DIGITALOCEAN_ACCESS_TOKEN=<your digitalocean access token>
$ dokkaacfg --provider=digitalocean down
```

Deletes all dokkaa instances from DigitalOcean.

# License

MIT
