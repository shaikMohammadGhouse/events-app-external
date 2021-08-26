FROM launcher.gcr.io/google/nodejs

#copy to app folder
COPY . /app
WORKDIR /app
RUN npm install

#start the express app
CMD ["npm", "start"]


#steps to run
#docker --version
#docker build --help
#docker build -t int_serv:v1 .
