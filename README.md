# FukuokaPmInfo

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'fukuoka_pm_info'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fukuoka_pm_info

## Usage

```
f = FukuokaPmInfo::Fukuoka.new
f.fetch_data
# => [
    {place: '香椎', values:[10, 10, ... 10, nil, ... nil]},
    ...
]

f.date
# => 2016-01-11 00:00:00 +0900

f.unit
# => "μg/m3"

```
