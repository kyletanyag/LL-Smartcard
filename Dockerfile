# Dockerfile to create Python CAC Reader Container
FROM python:3.8

WORKDIR /usr/src/app

ADD cacreader/ .

RUN apt-get -y update

RUN apt-get -y install pcsc-tools pcscd libusb-1.0-0-dev



WORKDIR /usr/src/app/swig-4.0.2

RUN ./configure && make && make install


WORKDIR /usr/src/app/pcsc-lite-1.9.5

RUN apt-get -y install libsystemd-dev libudev-dev 

RUN ./configure && make && make install


WORKDIR /usr/src/app/pyscard-2.0.2

RUN make

RUN python setup.py install


WORKDIR /usr/src/app

RUN pip install pyDes

RUN python setup.py install

# CMD [ "python", "./examples/common_access_card/cac_info.py" ]

## docker run --rm -it --privileged cac-reader bash  -c " service pcscd start && python ./examples/common_access_card/cac_info.py"

