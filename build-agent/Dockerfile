# Start with a base image that includes the necessary OS and basic tools
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    git \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Install Java (OpenJDK 11)
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Install Maven
RUN apt-get update && apt-get install -y maven

# (Optional) Install Python and pip if required for the build
RUN apt-get update && apt-get install -y python3 python3-pip

# Add a user to avoid running as root
RUN useradd -ms /bin/bash buildagent
USER buildagent

# Set up working directory
WORKDIR /home/buildagent

# Set environment variables for Java and Maven
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:${PATH}"

# Copy build scripts or agent setup files if necessary
# COPY build-scripts/ /home/buildagent/build-scripts/

# Set entrypoint or command for the agent
CMD ["tail", "-f", "/dev/null"] # Replace with actual entrypoint script if required