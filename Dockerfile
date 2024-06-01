FROM python:3.11-slim-bullseye as core-build

# Add PhasecoreX user-entrypoint script
ADD https://raw.githubusercontent.com/PhasecoreX/docker-user-image/master/user-entrypoint.sh /bin/user-entrypoint
RUN chmod +x /bin/user-entrypoint && /bin/user-entrypoint --init
ENTRYPOINT ["/bin/user-entrypoint"]

VOLUME /data

COPY root/ /

CMD ["/app/start-reddash.sh"]

HEALTHCHECK --start-period=5m CMD bash -c "exec 6<> /dev/tcp/127.0.0.1/42356"
