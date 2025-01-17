FROM alpine
# load any public updates from Alpine packages
RUN apk update
# upgrade any existing packages that have been updated
RUN apk upgrade
# add/install python3 and related libraries
# https://pkgs.alpinelinux.org/package/edge/main/x86/python3
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
#RUN python3 -m venv venv
#RUN source venv/bin/activate
RUN python3 -m ensurepip
# make a directory for our application
RUN mkdir -p /opt/exampleapp
# move requirements file into the container
COPY src /opt/exampleapp
# install the library dependencies for this application
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip3 install -r /opt/exampleapp/requirements.txt
ENTRYPOINT ["python3"]
CMD ["/opt/exampleapp/exampleapp.py"]
