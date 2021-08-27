FROM launcher.gcr.io/google/nodejs

#copy to app folder
COPY . /app
WORKDIR /app
RUN npm install

#start the express app
#local CMD ["npm", "start"]
#on kubernete
CMD ["node", "server.js"]

#steps to run
#docker --version
#docker build --help
#docker build -t int_serv:v1 .
