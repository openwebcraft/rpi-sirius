# Pull base image
FROM resin/rpi-raspbian:jessie
MAINTAINER Matthias Geisler<matthias@openwebcraft.com>

# Install and update system package dependencies and
# in the same layer upgrade pip as a workaround for 
# "docker overlayfs bug", https://github.com/pypa/pip/pull/3425 

RUN apt-get update && apt-get install -y \
    python \
    python-dev \
    python-pip \
    python-imaging \
    libpq-dev \
    ca-certificates \
    git \ 
    gcc \
    libfreetype6-dev \
    fontconfig \
    libgstreamer0.10-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install virtualenv

# Define working directory
WORKDIR /data

# Fetch and overwrite-install more recent version (1.9.8) of PhantomJS binary for Raspberry Pi
RUN git clone https://github.com/piksel/phantomjs-raspberrypi.git phantomjs-raspberrypi
RUN cp /data/phantomjs-raspberrypi/bin/phantomjs /usr/local/bin/ && \
    chmod +x /usr/local/bin/phantomjs

# Fetch sirius project
RUN git clone https://github.com/openwebcraft/sirius.git sirius

# Create and activate a virtual environment 
# for the sirius project and install requirements 
RUN cd /data/sirius && \
    virtualenv --system-site-packages venv && \
    . venv/bin/activate && \
    pip install -r requirements.txt

# Work around for "IOError: decoder zip not available":
# using PIL from system package python-imaging 
RUN cd /data/sirius && \
    . venv/bin/activate && \
    pip uninstall --yes Pillow
    
# Install Honcho, a python clone of Foreman.
# For managing Procfile-based applications.
RUN cd /data/sirius && \
    . venv/bin/activate && \
    pip install honcho
    
# Document that the service listens on port 5000.
EXPOSE 5000

# Migrate the database and start the server
ENTRYPOINT cd /data/sirius && \
    . venv/bin/activate && \
    ./manage.py db upgrade && \
    honcho start