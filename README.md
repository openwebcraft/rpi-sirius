#rpi-sirius

Docker image for [genmon/sirius](https://github.com/genmon/sirius), the bare bones back-end server doing basic messaging for Little Printer.

The image is intended for deployment on a Raspberry Pi, ARM hardware.

It will `git clone` the latest and greatest of *genmon/sirius* code base, install any dependencies and start the server, exposing port `5000`.

## Build and run the sirius Python server with Docker

Prerequisites on Raspberry Pi:

- Git, e.g. on Raspbian `sudo apt-get install git`
- Docker, e.g. [Hypriot Docker Image or Debian Packages for Raspberry Pi](http://blog.hypriot.com/downloads/)

Build the image:

    $ git clone https://github.com/openwebcraft/rpi-sirius.git
    $ cd rpi-sirius 
    $ docker build -t rpi-sirius .
    
Start a container from the image:

    $ docker run -d -p 5000:5000 rpi-sirius
