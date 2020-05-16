# Sonarqube integrations
Convenience scripts to integrate SonarQube scanners.
They're meant to be used primarily in CI environments.

## JavasScript / TypeScript
```bash
curl -o- https://raw.githubusercontent.com/learningtapestry/sonarqube-integrations/master/scanner-js.sh | bash
```
or
```bash
wget -qO- https://raw.githubusercontent.com/learningtapestry/sonarqube-integrations/master/scanner-js.sh | bash
```

## Ruby

ENV variables to customize setup:

`SONAR_RUBOCOP_REPORT` contains name for rubocop report file to be catched up sonar scanner. Default is `rubocop-report.json`. If report file doesn't exist rubocop scanner is executed to generate the report file.

If coverage file `coverage/.resultset.json` doesn't exist test command inside `SONAR_TEST_COMMAND` is executed. Default command is `bundle exec rake test || bundle exec rspec`.  Usually a command runs tests which generates a coverage.

```bash
curl -o- https://raw.githubusercontent.com/learningtapestry/sonarqube-integrations/master/scanner-ruby.sh | bash
```
or
```bash
wget -qO- https://raw.githubusercontent.com/learningtapestry/sonarqube-integrations/master/scanner-ruby.sh | bash
```
