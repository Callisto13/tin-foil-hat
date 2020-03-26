# tin-foil-hat

For paranoid folks who want to test code away from their home environment.

# What's in it?

The image is based on Ubuntu 19.10 and comes with various things installed, notably:

- Go version 1.14.1
- Kind version 0.8.0-alpha
- Kubectl version 1.17.0
- Some pimped out Vim and Tmux

# Running

To simply run the container as a sandbox for cloning and looking at stuff:

```sh
docker run -it callisto13/tin-foil-hat /bin/bash
```

To clone stuff and then deploy it to kube:

Running docker in docker is a pain in the ass and not generally advised. (Running
containers in containers _is_ doable, but I can't be bothered to set that up right now.)

So if whatever you are testing needs to deploy to docker/kube, you can run the container
with your host socket mounted. Any containers you create within the `tin-foil-hat`
container will appear as siblings on the host. Likewise, the `tin-foil-hat` container
will be visible from the inside. Try not to do anything stupid with it.

```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -it callisto13/tin-foil-hat /bin/bash
```

# Creating and connecting to clusters

Once inside you can create a `kind` cluster as you would normally, and connect
to it via `kubectl` (no bash shortcuts installed yet).

There is currently one manual step: the clusters you create will be in sibling
containers, which means you will need to connect to them via the host network, not
localhost.

Update the `server` field in `/root/.kube/config` to `https://host.docker.internal:<port>`.

_coming soon: connect to some other kube cluster already running on the host._

# Vim

If you want to use (decent) Vim while in the container, run the following:

```
/root/.vimupdate
```

It may complain at the start but don't worry about it.

