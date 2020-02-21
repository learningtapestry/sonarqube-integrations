#!/bin/bash

### SonarQube scanner for Javascript projects.
### It assumes you're using ESLint and Jest.
### Your user token must be stored in the SONAR_TOKEN environment variable.

# Install Sonar scanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip -P /tmp
unzip /tmp/sonar-scanner-cli-4.2.0.1873-linux.zip -d /tmp
export PATH=$PATH:/tmp/sonar-scanner-4.2.0.1873-linux/bin

# Configure Learning Tapestry SonarQube server
sed -i 's|#sonar.host.url=http://localhost:9000|sonar.host.url=https://sonarqube.learningtapestry.com|g' \
  /tmp/sonar-scanner-4.2.0.1873-linux/conf/sonar-scanner.properties

# Generate ESLint report
eslint 'src/**' -f json -o eslint-report.json || true

# Generate test coverage report
jest --coverage

# Run scanner
cd -P . || true # Needed because CodeShip stores the code using a symbolic link that gives problems to the scanner
sonar-scanner -Dsonar.login="$SONAR_TOKEN"
