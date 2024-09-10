# Stage 1: Build stage
FROM node:16 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Runtime stage
FROM node:16-slim

# Set working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app ./

# Expose port and define command to run the application
EXPOSE 3000
CMD [ "npm", "start" ]
