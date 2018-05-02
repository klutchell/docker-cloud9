# resin-cloud9

[cloud9 ide](https://c9.io/) service for [resin.io](https://resin.io/) stacks

## Getting Started

* https://docs.resin.io/learn/getting-started
* https://docs.c9.io/docs/getting-started

## Deployment

```bash
docker run --name cloud9 \
-v cloud9-workspace:/cloud9-workspace \
-p 8080:8080 \
-e TZ=America/Toronto \
klutchell/resin-cloud9
```

## Usage

browse to `http://<device-ip>:8080` to access the web IDE

## Author

Kyle Harding <kylemharding@gmail.com>

## License

_tbd_

## Acknowledgments

* https://github.com/hwegge2/rpi-cloud9-ide

