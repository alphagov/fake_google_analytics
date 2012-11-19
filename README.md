## About

Fake Google Analytics (GA)  is a tool used to shorten the feedback loop
when testing the interaction of a website with Google Analytics.
It does so by redirecting all traffic to www.google-analytics.com to the
web server run locally, storing it in the file, and exposing via simple
HTTP interface. (an entry in /etc/hosts is added)

## Installation

Run:

    rvmsudo bundle install

'sudo' is necessary as adding an entry to the hosts file require root 
privileges.

## Usage

In order to start intercepting all GA traffic execute:

    bundle exec rake fake_ga:run

In order to clear the file containg all intercepted GA requests execute:

    bundle exec rake fake_ga:clear

## Accessing GA data

You can access data via HTTP:

  - List of all requests: http://www.google-analytics.com/list
  - List of the events:   http://www.google-analytics.com/events

You can purge collected data by executing DELETE method against:

  - http://www.google-analytics.com/

You can also find a list of all requests to GA in the file: "db/requests.yml"

## Technical details

This tool works by adding a custom entry to the hosts file. When this tool 
is running all traffic that goes to www.google-analytics.com is going to be
"intercepted" and logged instead of going to GA.

## License

Fake Google Analytics is released under the MIT license, a copy of which can be found
in ``LICENSE``.

The public/ga/ folder contains code snippets from google see: "https://developers.google.com/analytics/devguides/collection/gajs/methods/"
