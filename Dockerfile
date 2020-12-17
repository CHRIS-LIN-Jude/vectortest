FROM ubuntu:18.04

RUN mkdir /logs
RUN mkdir /vector
WORKDIR /logs
COPY vector.yaml /vector/vector.yaml

# install vector
RUN apt-get update 
RUN apt-get install -y  curl
RUN curl -1sLf \
      'https://repositories.timber.io/public/vector/cfg/setup/bash.deb.sh' \
      | sudo -E bash
RUN apt-get install vector
RUN apt-get update && apt-get install -y ca-certificates tzdata systemd && rm -rf /var/lib/apt/lists/*


EXPOSE 8000 2222 80 443 9000

#CMD ["python", "/code/manage.py", "runserver", "0.0.0.0:8000"]
ENTRYPOINT ["/usr/bin/vector","--config", "/vector/vector.yaml"]
