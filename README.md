# LogsParser

A Ruby script which parses log files.

## Installation

    $ bundle exec bin/setup

## Usage

To show webpages with most page views ordered descending:

    $ ./bin/parse file webserver.log

To show webpages with the most unique page views ordered in the same way:

    $ ./bin/parse file webserver.log --unique
