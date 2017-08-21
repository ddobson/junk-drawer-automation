## Junk Drawer Automation Suite

This repository contains automated tests for the Junk Drawer app. Tests are written in Ruby and make use of Selenium, Cucumber, and Capybara.

Junk Drawer is a bookmarking and link rebranding application. To examine its source code or view a live version, visit the links below.

- [Application](https://junk-drawer-app.herokuapp.com)
- [Source Code](https://github.com/ddobson/junk-drawer)

### Installation & Usage

_NOTE: This repository is configured to run an automated suite of integration tests against the production instance of Junk Drawer. Current configuration options only support Google Chrome in Mac OS._

##### Clone the repo

```
git clone git@github.com:ddobson/junk-drawer-automation.git
cd junk-drawer-automation
```

##### Install dependencies

```
bundle install
```

##### Configure the .env file
Copy the sample file to a new `.env` file.

```
cp .env_sample .env
```

Adjust the password to something of your choosing (a valid password is at least 8 characters). Leave `BROWSER` set to `chrome` as other browser options have not yet been configured.

##### Run the test suite

```
bundle exec cucumber features
```
