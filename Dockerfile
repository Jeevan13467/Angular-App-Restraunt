# --- Stage 1: Build the Angular Application ---
FROM node:20-alpine AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the application in production mode
RUN npm run build -- --configuration=production

# --- Stage 2: Serve the application using Nginx ---
FROM nginx:alpine

# Copy the compiled static files from the build stage to Nginx's web root
# Note: Check your dist/ folder name after building; modern Angular usually outputs to dist/[project-name]/browser
COPY --from=build /app/dist/japanese-restaurant/browser /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
