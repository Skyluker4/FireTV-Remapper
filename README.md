# FireTV Home Remapper

Pushes files to FireTV to remap home button and power to a custom launcher. Needs to be run on every reboot of the FireTV.

Based on [this](https://xdaforums.com/t/workaround-to-remap-home-key.4527599/post-89683403) XDA thread.

## Usage

Can install to any SystemD enabled system, any UNIX system with a cron job, or with Docker.

DEVICE should be in the format of `IP:PORT`. For example `192.168.1.2:5555`.

### SystemD

1. Run `./install.sh --systemd` to install the service.
2. Run `systemctl enable firetv-remap@DEVICE.timer` to enable the service to check on the FireTV.
3. Run `systemctl start firetv-remap@DEVICE.service` to start the service immediately for first use.

To change the launcher, edit the `am start` value in the scripts `watch-home.sh` and `watch-power.sh`.

### Cron

1. Run `./install.sh --cron` to install the service.
2. Edit the crontab to add the device as one of:
   - An argument to `firetv-activate-remap`. Ex: `firetv-activate-remap 192.168.1.2:5555`
   - As an environment variable, `DEVICE`. Ex: `DEVICE=192.168.1.2:5555`

### Docker

1. Run `docker build . -t firetv-remap` to build the Docker image.
2. Run `docker run -e DEVICE=$DEVICE` to run the Docker container, where `$DEVICE` is the IP:PORT of the FireTV.
