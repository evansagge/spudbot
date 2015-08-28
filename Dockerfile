FROM ubuntu

RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN useradd -d /spudbot -m -s /bin/bash -U spudbot

# Log in as hubot user and change directory
USER    spudbot
WORKDIR /spudbot

# Install hubot
RUN yo hubot --owner="Evan <evan@entelo.com>" --name="Spud-Bot" --description="HuBot on Docker" --defaults

RUN npm install hubot-slack --save && npm install
CMD bin/hubot -a slack
