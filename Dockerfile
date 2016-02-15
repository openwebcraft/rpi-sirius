FROM hypriot/rpi-python

# Install and update system package dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    git \
    libpq-dev python-dev python-setuptools gcc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

# Fetch and install PhantomJS binary for Raspberry Pi
RUN git clone https://github.com/piksel/phantomjs-raspberrypi.git phantomjs-raspberrypi
RUN cp /data/phantomjs-raspberrypi/bin/phantomjs /usr/local/bin/ && \
    chmod +x /usr/local/bin/phantomjs

# Fetch sirius project
RUN git clone https://github.com/genmon/sirius.git sirius

# Make sure virtualenv is installed
RUN pip install virtualenv

WORKDIR /data/sirius

# Create and activate a virtual environment 
# for the sirius project and install requirements 
RUN cd /data/sirius && \
    virtualenv venv --system-site-packages && \
    . venv/bin/activate && \
    pip install -r requirements.txt
    
# Install Honcho, a python clone of Foreman.
# For managing Procfile-based applications.
RUN cd /data/sirius && \
    . venv/bin/activate && \
    pip install honcho

# As a work-around for SSLv3 errors, let's upgrade gevent
RUN cd /data/sirius && \
    . venv/bin/activate && \
    pip install gevent==1.0.2
    
# Document that the service listens on port 5000.
EXPOSE 5000

# Migrate the database and start the server
ENTRYPOINT cd /data/sirius && \
    . venv/bin/activate && \
    ./manage.py db upgrade && \
    honcho start