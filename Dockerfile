FROM python:3.11-slim-bullseye as core-build

# Add PhasecoreX user-entrypoint script
ADD https://raw.githubusercontent.com/PhasecoreX/docker-user-image/master/user-entrypoint.sh /bin/user-entrypoint
RUN chmod +x /bin/user-entrypoint && /bin/user-entrypoint --init
ENTRYPOINT ["/bin/user-entrypoint"]

VOLUME /data

ARG PCX_DASHBOARD_BUILD
ARG PCX_DASHBOARD_COMMIT

ENV PCX_DASHBOARD_BUILD ${PCX_DASHBOARD_BUILD}
ENV PCX_DASHBOARD_COMMIT ${PCX_DASHBOARD_COMMIT}

COPY root/ /

CMD ["/app/start-reddash.sh"]

