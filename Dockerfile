# Stage 1: Install dependencies (build stage)
FROM node:16 AS dependencies

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Stage 2: Use a lightweight image for running the app
FROM node:16-slim

WORKDIR /app

# Copy only the necessary files from the dependencies stage
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
