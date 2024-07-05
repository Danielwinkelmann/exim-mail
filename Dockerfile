# Use Debian as the base image
FROM debian:bullseye-slim

# Install Exim and other necessary packages
RUN apt-get update && apt-get install -y exim4-daemon-light

# Copy Exim configuration files from the Git repository
COPY exim4.conf /etc/exim4/exim4.conf
COPY passwd.client /etc/exim4/passwd.client

# Expose the SMTP port
EXPOSE 25

# Start Exim
CMD ["exim", "-bd", "-q30m"]