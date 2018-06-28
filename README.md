# docker-cloud9

[cloud9](https://c9.io/) docker images

## Build

```bash
# build for x86_64
make

# build for armhf
make armhf
```

## Deploy

```bash
docker run --name cloud9 \
    -v cloud9_home:/root \
    -v cloud9_workspace:/workspace \
    -p 8080:8080 \
    -e TZ=America/Toronto \
    -e C9_USER=root \
    -e C9_PASS=cloud9 \
    --privileged \
    klutchell/cloud9:armhf-latest
```

## Parameters

* `-v cloud9_home:/root` - persistent home volume
* `-v cloud9_workspace:/workspace` - persistent workspace volume
* `-p 8080:8080` - webui port (internal and external)
* `-e TZ=America/Toronto` - local timezone
* `-e C9_USER=root` - webui basic auth username
* `-e C9_PASS=cloud9` - webui basic auth password
* `--privileged` - is required to run docker-in-docker

## Usage

* log into the [cloud9 ide](https://c9.io/) by visiting `http://<server-ip>:8080`

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/hwegge2/rpi-cloud9-ide
* https://github.com/kdelfour/cloud9-docker