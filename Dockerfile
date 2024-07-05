# Dockerfile
FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y postfix dovecot-imapd dovecot-pop3d curl cron && \
    apt-get clean

# Copy mail processing script
COPY process_emails.sh /usr/local/bin/process_emails.sh
RUN chmod +x /usr/local/bin/process_emails.sh

# Copy cron job directly into cron directory
COPY cronjob /etc/cron.d/mail-cron
RUN chmod 0644 /etc/cron.d/mail-cron

# Copy Postfix and Dovecot configurations
COPY postfix/main.cf /etc/postfix/main.cf
COPY dovecot/dovecot.conf /etc/dovecot/dovecot.conf

# Expose ports for Postfix and Dovecot
EXPOSE 25 143 110

# Start services
CMD service postfix start && service dovecot start && cron -f
