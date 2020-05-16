#!/bin/bash

### SonarQube scanner for Ruby projects.
### It assumes you're using Rubocop.
### Your user token must be stored in the SONAR_TOKEN environment variable.

# Install Sonar scanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip -P /tmp
unzip /tmp/sonar-scanner-cli-4.2.0.1873-linux.zip -d /tmp
export PATH=$PATH:/tmp/sonar-scanner-4.2.0.1873-linux/bin

# Configure Learning Tapestry SonarQube server
sed -i 's|#sonar.host.url=http://localhost:9000|sonar.host.url=https://sonarqube.learningtapestry.com|g' \
 /tmp/sonar-scanner-4.2.0.1873-linux/conf/sonar-scanner.properties

# Generate Rubocop report if not exists
report_file=${SONAR_RUBOCOP_REPORT:-'rubocop-report.json'}
if [ ! -e "$report_file" ]; then
  bundle exec rubocop --format=json --out="$report_file" || true
fi

# Generate test coverage report if none has been generated
if [ ! -e 'coverage/.resultset.json' ]; then
  eval "${SONAR_TEST_COMMAND:-'bundle exec rake test || bundle exec rspec'}"
fi

# Run scanner
cd -P . || true # Needed because CodeShip stores the code using a symbolic link that gives problems to the scanner
sonar-scanner -Dsonar.login="$SONAR_TOKEN"
