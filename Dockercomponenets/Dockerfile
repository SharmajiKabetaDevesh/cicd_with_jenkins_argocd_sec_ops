
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    unzip wget openjdk-11-jdk fontconfig python3-pip docker.io git && \
    rm -rf /var/lib/apt/lists/*

# Install SonarScanner
RUN wget -O sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    unzip sonar-scanner.zip -d /opt/ && \
    mv /opt/sonar-scanner-* /opt/sonar-scanner && \
    rm sonar-scanner.zip

# Set environment variable to make sonar-scanner globally accessible
ENV PATH="/opt/sonar-scanner/bin:${PATH}"

# Verify installation
RUN java -version && sonar-scanner -v

# Set default command
CMD ["sonar-scanner", "-v"]
