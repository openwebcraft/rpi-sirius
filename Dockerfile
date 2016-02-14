# Start from Hypriot crew's Python image
FROM hypriot/rpi-python

# Install and update system package dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    git \
    libpq-dev python-dev python-setuptools \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

# Fetch and install PhantomJS binary for Raspberry Pi
RUN git clone https://github.com/piksel/phantomjs-raspberrypi.git phantomjs-raspberrypi
RUN cp /data/phantomjs-raspberrypi/bin/phantomjs /usr/local/bin/ && \
    chmod +x /usr/local/bin/phantomjs

# Fetch and sirius project
RUN git clone https://github.com/genmon/sirius.git sirius

# Install virtualenv
RUN pip install virtualenv

# Create and activate a virtual environment 
# for the sirius project and install requirements 
RUN cd /data/sirius && \
    virtualenv venv && \
    source venv/bin/activate && \
    pip install -r requirements.txt
    
# Install Honcho, a python clone of Foreman.
# For managing Procfile-based applications.
RUN pip install honcho

# To work around SSLv3 errors, try to upgrade gevent
RUN pip install gevent==1.0.2
    
# Migrate the database
RUN cd /data/sirius && \
    python manage.py db upgrade

CMD [ "honcho", "start" ]

# Document that the service listens on port 5000.
EXPOSE 5000