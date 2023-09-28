# Use an official Maven image as the base image
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Build the Maven project
RUN mvn clean install -DskipTests

# Use a minimal base image for running the application
FROM openjdk

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR (or other artifact) from the build image to the runtime image
COPY --from=build /app/target/spring-petclinic-3.1.0-SNAPSHOT.jar .  

# Expose the port on which your application listens (if needed)
EXPOSE 8080

# Define the command to run your Java application
CMD ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar"]  
