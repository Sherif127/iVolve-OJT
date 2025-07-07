# Use official Node.js image
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY . .

# Install dependencies
RUN npm install

# Run the app
CMD ["npm", "start"]
