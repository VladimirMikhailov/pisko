# Pisko

[![Build
Status](https://semaphoreci.com/api/v1/VladimirMikhailov/pisko/branches/master/badge.svg)](https://semaphoreci.com/VladimirMikhailov/pisko)

The app aims to gather information about latest activity from github
and write it to log in order to build graphs and stats and the end

## Dependencies

  - Elasticsearch
  - [StatsD](https://github.com/etsy/statsd)
  - [StatsD ElasticSearch](https://github.com/markkimsal/statsd-elasticsearch-backend)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add pisko to your list of dependencies in `mix.exs`:

        def deps do
          [{:pisko, "~> 0.0.1"}]
        end

  2. Ensure pisko is started before your application:

        def application do
          [applications: [:pisko]]
        end

