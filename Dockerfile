# Stage 1: Install dependencies
FROM node:16 AS dependencies

WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Stage 2: Use a lightweight image for running the app
FROM node:16-slim

WORKDIR /app

# Copy the application source code first
COPY . .

# Install dependencies directly in this stage
RUN npm install --production

# Expose the application port
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
