# Step 1: Build the app
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Step 2: Serve the app with Nginx
FROM nginx:latest

# Copy the built app to Nginx's default public folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# No need to specify CMD as the default command for Nginx is sufficient
