# Kubernetes toolbox

Launch a shell in a semi-persistent pod on a cluster, with automatic expiration when idle.

When running `ktoolbox` it will check if an existing toolbox pod is running,
then exec into it and start a bash shell. If the pod does not exist, or has
exited, the script will (re)create it before proceeding.

The default maximum idle time before exiting is 180 minutes, but can be
customized using the `-i` flag.

```% ktoolbox
 _______          _ _                              Node: gke-myproject-cluster-nodes-df48b632-bcb2
|__   __|        | | |                          Host IP: 192.168.42.89
   | | ___   ___ | | |__   _____  __      Pod Namespace: default
   | |/ _ \ / _ \| | '_ \ / _ \ \/ /           Pod Name: toolbox-dln
   | | (_) | (_) | | |_) | (_) >  <              Pod IP: 192.168.100.21
   |_|\___/ \___/|_|_.__/ \___/_/\_\    Service Account: default

default/toolbox-dln:~$
```

## Installation

Copy [the ktoolbox script](https://raw.githubusercontent.com/dln/ktoolbox/master/ktoolbox) somewhere within your `$PATH` and make it executable.

### Customizing the container
The container contains various useful utilities, but may be customized to taste
(the entrypoint script is important though, as that contains the persistence and
timeout logic). Easiest is to make a custom Dockerfile like this:

```
FROM dlneintr/toolbox
RUN sudo apk add -U --no-cache memcached redis
```

You can override the image used by ktoolbox with either the `-c` flag or,
more conveniently, by setting the `KTOOLBOX_IMAGE` environment variable.

## Usage

```
  ktoolbox [-c image] [-i max_idle_mins] [-n namespace] [cmd...]
    -h                 Display this help message.
    -n NAMESPACE       Use given namespace instead of context default.
    -i MAX_IDLE_MINS   Max idle time in minutes before exiting. 180 mins by default.
    -c IMAGE           Override default container image (dlneintr/toolbox:latest).
                       Can also be set using KTOOLBOX_IMAGE environment variable.
```
