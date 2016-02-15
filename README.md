#rpi-sirius

Docker image for [genmon/sirius](https://github.com/genmon/sirius), the bare bones back-end server doing basic messaging for Little Printer.

The image is intended for deployment on a Raspberry Pi, ARM hardware.

It will `git clone` the latest and greatest of *genmon/sirius* code base, install any dependencies and start the server, exposing port `5000`.

## Build and run the sirius Python server with Docker on Raspberry Pi

Prerequisites on Raspberry Pi:

- Git, e.g. on Raspbian `sudo apt-get install git`
- Docker, e.g. [Hypriot Docker Image or Debian Packages for Raspberry Pi](http://blog.hypriot.com/downloads/)

Build the image:

    $ git clone https://github.com/openwebcraft/rpi-sirius.git
    $ cd rpi-sirius 
    $ docker build --no-cache -t rpi-sirius .
    
Start a container from the image:

    $ docker run -d -p 5000:5000 rpi-sirius

## Build and publish image to Docker Hub on Raspberry Pi

    $ docker build --no-cache -t matthiasg/rpi-sirius .

    $ docker tag [IMAGEID] matthiasg/rpi-sirius:latest
    
    $ docker login --username=[DOCKER_HUB_USERNAME] --email=[DOCKER_HUB_EMAIL]
    
    $ docker push matthiasg/rpi-sirius