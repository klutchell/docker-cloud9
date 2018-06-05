# klutchell/cloud9

[cloud9](https://c9.io/) docker images

## Build

```bash
# build default
make

# build for rpi3
make build-rpi3
```

## Deploy

```bash
docker run --name cloud9 \
-v cloud9-data:/root/.c9 \
-v cloud9-workspace:/workspace \
-p 8080:8080 \
-e TZ=America/Toronto \
klutchell/cloud9:latest
```

## Parameters

* `-v cloud9-data:/root/.c9` - persistent data volume
* `-v cloud9-workspace:/workspace` - persistent workspace volume
* `-p 8080:8080` - port to expose
* `-e TZ=America/Toronto` - local timezone

## Usage

* log into the [cloud9 ide](https://c9.io/) by visiting `http://<server-ip>:8080`

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/hwegge2/rpi-cloud9-ide