# Docker container for PhoenixMiner

A Docker container that includes AMDGPU drivers and PhoenixMiner ready to be used.

This container was built to include only the OpenCL 20.45 drivers. It's a slimmed down version that only uses 254MB.

## Installation

Pull the image from the docker registry.

```bash
docker pull cebxan/phoenix-miner
```

## Usage

```bash
docker run --rm --name "phoenix-miner" \
   --net='bridge' \
   --device='/dev/dri:/dev/dri' \
   -e TZ="America/Caracas" \
   -e POOL="<your pool address>" \
   -e WALLET="<your wallet address>" \
   -e WORKER="<worker id>"
   -e EXTRA_ARGS="<any extra flags passed to PhoenixMiner>" \
   cebxan/phoenix-miner
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
