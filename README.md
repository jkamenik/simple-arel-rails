# Simple Arel for Rails

[![Build Status](https://travis-ci.org/jkamenik/simple-arel-rails.png)](https://travis-ci.org/jkamenik/simple-arel-rails)

This is entirely based off RailsCast #355: Hacking with Arel.  100% of the credit goes to Ryan Bates.

I haven't wanted to use Squeel or meta_where, but only because they add a lot more then I would ever use and have a syntax different then I liked.  And I actually don't like the predicate loader from the episode so I didn't include that.

## Background

Originally I had thought about extracting something similar from a project that I was doing and wanted to use "or" in where clauses easily.  The other Arel wrapper, though awesome, were more then I wanted.  Then I sumbled upon the Hacking with Arel Railscast (you do have a "pro" account, right?) and it turned out to be exactly what I wanted.  Justed need to write tests to ensure it behaved as expected.

## Installation

Add this line to your application's Gemfile:

    gem 'simple-arel-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple-arel-rails

## Usage

    class User < ActiveRecord::Base
      scope :name,          ->(name)    {where(:name => name)}
      scope :title,         ->(title)   {where(:title => title)}
      scope :name_or_title, ->(test)    {name(test) | title(test)}
      scope :everyone_but,  ->(person)  {not name(test)}
      scope :hard_worker,   ->(company) {where(:company => company) & h_where(:hours_per_week => {:gt => 40})}
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
