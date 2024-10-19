FROM alpine:3.20.3

COPY crontab /etc/cron.d/firetv-remap

COPY firetv-activate-remap /usr/local/bin/
RUN chmod +x /usr/local/bin/firetv-activate-remap

COPY ./start-me.sh /usr/local/share/firetv-remap/
COPY ./watch-home.sh /usr/local/share/firetv-remap/
COPY ./watch-power.sh /usr/local/share/firetv-remap/

CMD ["crond", "-f"]
