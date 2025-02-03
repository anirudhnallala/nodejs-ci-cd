# Dockerfile

# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container's working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the rest of the application files into the container
COPY . .

# Expose port 3000 for the app to listen on
EXPOSE 3000

# Define the command to run the app (npm start will run the server)
CMD ["npm", "start"]

