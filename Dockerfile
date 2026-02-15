#1. Use ubuntu as the base OS
FROM ubuntu:latest

#2 Set the working directory inside the container
WORKDIR /app

#3 Copy your script from Mac to the container
COPY monitor.sh .

#4 Give the script permissions to run
RUN chmod +x monitor.sh

#5 Run script when container starts
CMD ["./monitor.sh"]


