FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y apache2 mariadb-server php libapache2-mod-php php-mysql phpmyadmin

RUN echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80
EXPOSE 3306

RUN echo '#!/bin/bash' > /usr/local/bin/damp && \
    echo 'if [ "$1" = "reload" ]; then' >> /usr/local/bin/damp && \
    echo '    apachectl -k graceful' >> /usr/local/bin/damp && \
    echo '    echo "Apache reloaded successfully."' >> /usr/local/bin/damp && \
    echo 'else' >> /usr/local/bin/damp && \
    echo '    echo "Usage: damp reload"' >> /usr/local/bin/damp && \
    echo 'fi' >> /usr/local/bin/damp && \
    chmod +x /usr/local/bin/damp

CMD ["apachectl", "-D", "FOREGROUND"]
