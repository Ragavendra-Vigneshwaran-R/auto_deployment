#Specify a base image
FROM node:alpine

WORKDIR / opt/app

#Copy the project
COPY ./ ./

#Install dependencies
RUN npm install 

EXPOSE 3000

#Default command
CMD ["npm","start"]
