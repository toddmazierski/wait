[![Build Status](https://travis-ci.org/toddmazierski/wait.png?branch=master)](https://travis-ci.org/toddmazierski/wait)

## Description

The wait gem executes a block until there's a valid (by default, truthy) result. Useful for blocking script execution until:
* an HTTP request was successful
* a port has opened
* a process has started
* etc.

## Installation

Add to your `Gemfile`:

```ruby
gem "wait", "~> 0.5.3"
```

## Examples

```ruby
wait = Wait.new
# => #<Wait>
wait.until { Time.now.sec.even? }
# [Counter] attempt 1/5
# [Tester]  result: false
# [Rescuer] rescued: Wait::ResultInvalid
# [Raiser]  not raising: Wait::ResultInvalid
# [Delayer] delaying for 1s
# [Counter] attempt 2/5
# [Tester]  result: true
# => true
```

If you wish to handle an exception by attempting the block again, pass one or an array of exceptions with the `:rescue` option.

```ruby
wait = Wait.new(:rescue => RuntimeError)
# => #<Wait>
wait.until do |attempt|
  case attempt
  when 1 then nil
  when 2 then raise RuntimeError
  when 3 then "foo"
  end
end
# [Counter] attempt 1/5
# [Tester]  result: nil
# [Rescuer] rescued: Wait::ResultInvalid
# [Raiser]  not raising: Wait::ResultInvalid
# [Delayer] delaying for 1s
# [Counter] attempt 2/5
# [Rescuer] rescued: RuntimeError
# [Raiser]  not raising: RuntimeError
# [Delayer] delaying for 1s
# [Counter] attempt 3/5
# [Tester]  result: "foo"
# => "foo"
```

## Basic Options

<dl>
  <dt>attempts</dt>
  <dd>Number of times to attempt the block. Default is <code>5</code>.</dd>
  <dt>timeout</dt>
  <dd>Seconds until the block times out. Default is <code>15</code>.</dd>
  <dt>delay</dt>
  <dd>Seconds to delay in between attempts. Default is <code>1</code>.</dd>
  <dt>rescue</dt>
  <dd>One or an array of exceptions to rescue. Default is <code>nil</code>.</dd>
  <dt>debug</dt>
  <dd>If <code>true</code>, debug logging is enabled. Default is <code>false</code>.</dd>
</dl>

## Advanced Options

<dl>
  <dt>logger</dt>
  <dd>Ruby logger used. Default is <code>Wait::BaseLogger</code>.</dd>
  <dt>counter</dt>
  <dd>Strategy used to count attempts. Default is <code>Wait::BaseCounter</code>.</dd>
  <dt>delayer</dt>
  <dd>Strategy used to delay in between attempts. Default is <code>Wait::RegularDelayer</code>.</dd>
  <dt>rescuer</dt>
  <dd>Strategy used to rescue exceptions. Default is <code>Wait::BaseRescuer</code>.</dd>
  <dt>tester</dt>
  <dd>Strategy used to test the result. Default is <code>Wait::TruthyTester</code>.</dd>
  <dt>raiser</dt>
  <dd>Strategy used to raise specific exceptions. Default is <code>Wait::SignalRaiser</code>.</dd>
</dl>

## Documentation

RDoc-generated documentation available [here](http://toddmazierski.github.io/wait/Wait.html).
