# docker-cloud9

[cloud9](https://c9.io/) docker images

## Build

```bash
make build ARCH=armhf
```

## Deploy

```bash
docker run --name cloud9 \
-v cloud9-data:/root/.c9 \
-v cloud9-workspace:/workspace \
-p 8080:8080 \
-e TZ=America/Toronto \
klutchell/cloud9:armhf-latest
```

## Parameters

* `-v cloud9-data:/root/.c9` - persistent data volume
* `-v cloud9-workspace:/workspace` - persistent workspace volume
* `-p 8080:8080` - ports to expose
* `-e TZ=America/Toronto` - local timezone

## Usage

* log into the [cloud9 ide](https://c9.io/) by visiting `http://<server-ip>:8080`

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/hwegge2/rpi-cloud9-ide