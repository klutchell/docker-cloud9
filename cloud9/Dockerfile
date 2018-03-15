FROM kdelfour/cloud9-docker:latest

# set timezone
ENV TZ=America/Toronto
RUN echo $TZ > /etc/timezone && dpkg-reconfigure tzdata || true
# ENV TZ=America/Toronto
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
