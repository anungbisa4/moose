# Base image
FROM node:14.16.0-alpine3.13 AS build

# Working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# # Install dependencies
# RUN npm ci --production

# Copy the rest of the app
COPY . .

# Build the app
RUN npm run build

# Start from a fresh image
FROM node:14.16.0-alpine3.13 AS production

# Create a directory for the app
WORKDIR /app

# Copy the app
COPY --from=build /app/package*.json ./
COPY --from=build /app/.next ./.next

# Install only production dependencies
# RUN unset http_proxy
# RUN unset https_proxy
# RUN npm ci --production

# Start the app
CMD ["npm", "start"]
