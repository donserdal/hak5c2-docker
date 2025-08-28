FROM alpine:3.22
# Set variables and defaults
LABEL org.opencontainers.image.authors="Serdal Ozkan <donserdal@hotmail.com>"

ENV HKHostname=${hostname}
ENV USER=hak5
ENV UID=1000
ENV GID=1000
# Create group and user
RUN addgroup \
         -S "$USER" \
        --gid "$GID" \
    && adduser \
        --disabled-password \
        --gecos "" \
        --home "$(pwd)" \
        --ingroup "$USER" \
        --no-create-home \
        --uid "$UID" \
        "$USER"

# Install wget for download, unzip to unzip file and curl for health check, Create directory's and set owner
RUN apk add --no-cache wget unzip curl \
    && mkdir /hak5 \
    && mkdir /hak5/data \
    && chown -R ${USER}:${USER} /hak5

# Change working dir to /hak5
WORKDIR /hak5

# Change user to defined user
USER ${USER}

# Download latest c2 binary, unzip, remove all but the needed files and rename latest to latest
RUN wget -q https://c2.hak5.org/download/latest -O cloudc2.zip \
    && unzip cloudc2.zip \
    && find . -type f ! -name '*amd64_linux' -delete \
    && mv c2*_amd64_linux c2-latest && apk del --no-cache unzip

# Copy run file to container
COPY run.sh /hak5

# Define Healthcheck, curl's localhost to see if it still serves a page
HEALTHCHECK --interval=1m --timeout=5s --start-period=5s\
  CMD curl -f http://localhost:8080/ || exit 1

# Define a data volume
VOLUME [ "/hak5/data" ]

# Expose port 8080 for the webinterface and 2022 for SSH
EXPOSE 8080/tcp 2022

#(OLD) Entrypoint for the container 
#ENTRYPOINT exec /hak5/c2-latest --db /hak5/data/c2.db --hostname ${HKHostname}

# Entrypoint is now CMD with the scipt
CMD /bin/sh /hak5/run.sh
