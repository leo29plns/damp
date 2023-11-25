FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y apache2 mariadb-server php libapache2-mod-php php-mysql phpmyadmin

RUN echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

EXPOSE 80
EXPOSE 3306

RUN echo -e '#!/bin/bash\nif [ "$1" = "reload" ]; then\n  apachectl -k graceful\n  echo "Apache rechargé avec succès."\nelse\n  echo "Usage: damp reload"\nfi' > /usr/local/bin/damp && \
    chmod +x /usr/local/bin/damp

CMD ["apachectl", "-D", "FOREGROUND"]
