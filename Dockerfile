FROM nginx:1.17.6

LABEL MAINTAINER="<thiagozaranza@gmail.com>"

ENV DEBIAN_VERSION "stretch"

RUN apt update

RUN apt install -y 	apt-utils \
						curl \
						gnupg \
						procps \
						supervisor \
						git \
						build-essential \
						vim \
						perl

RUN apt update

RUN set -ex \
    && cd /usr/share/nginx/html/ \
	&& curl -sL https://deb.nodesource.com/setup_12.x | bash - \
	&& apt-get install -y nodejs \
	&& npm i npm@6.14.8 -g \
	&& npm install -g @angular/cli@11.2.1

ADD default.conf /etc/nginx/conf.d/default.conf

EXPOSE 4200

WORKDIR /usr/share/nginx/html/

CMD ["ng","serve","--host", "0.0.0.0"]