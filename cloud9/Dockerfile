FROM kdelfour/cloud9-docker:latest

# set timezone

ENV TZ=America/Toronto

# RUN echo $TZ > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean