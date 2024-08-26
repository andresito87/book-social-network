# Build stage
FROM maven:3.8.7-openjdk-18 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline # Download dependencies
COPY src ./src
RUN mvn clean package -DskipTests # Skip tests

# Runtime stage
FROM amazoncorretto:17
# arguments to be applied to the image when running the container
ARG PROFILE=dev
ARG APP_VERSION=1.0.0
# define the working directory
WORKDIR /app
# copy the packaged jar file into our container
COPY --from=build /build/target/book-network-*.jar /app/
# expose the port
EXPOSE 8088
# set environment variables used in the jar file to be run
ENV DB_URL=jdbc:postgresql://postgres-sql-bsn:5432/book_social_network
ENV ACTIVE_PROFILE=${PROFILE}
ENV JAR_VERSION=${APP_VERSION}
# define the command to run your jar file
CMD java -jar -Dspring.profiles.active=${ACTIVE_PROFILE} -Dspring.datasource.url=${DB_URL} book-network-${JAR_VERSION}.jar 