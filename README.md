# Kernel#fetch_in

This gem is for people who need to leap boldy into deep and treacherous hashes.
It adds a single method to Kernel, `#fetch_in`.  If you know Clojure, you can
think of it as a Ruby version of `get-in`.

```ruby
# from this:
customer = response['customer']
billing = customer_hash['billing_address'] if customer
country_code = billing['country'] if billing
do_something(with: country_code) if country_code

# to this:
country_code = fetch_in(response, 'customer', 'billing_address', 'country') { false }
do_something(with: country_code) if country_code

# or maybe even
do_something(with: fetch_in(response, 'customer', 'billing_address', 'country') { 'N/A' }
```

## Installation

Stick this in your Gemfile:
```ruby
gem 'kernel-fetch_in'
```

## Usage

```
fetch_in(collection, *keys) → obj
fetch_in(collection, *keys) { |key| block } → obj
```

`fetch_in` looks up values in nested Hashes (and Arrays, and anything else with
a `#fetch` method).  First it fetches the value in the passed collection at the first key,
then it fetches the value in that value at the next key, if any, and so on for
all keys passed, returning the last value fetched.

```ruby
bob = {
  powers: {
    strength: 'super',
    toughness: 'extreme'
  }
}
helen = {
  powers: {
    flexibility: 'extreme',
    flight: 'expert'
  }
}

fetch_in(bob, :powers, :strength) #=> 'super'
fetch_in(helen, :powers, :flight) #=> 'expert'
```

If the optional block parameter is passed, it is evaluated for a default value
when any of the passed keys are not present.

```ruby
fetch_in(bob, :powers, :flexibility) { 'normal' } #=> 'normal'
fetch_in(helen, :weaknesses, :physical) { 'unknown' } #=> 'unknown'
```

## Contributing

1. [Fork it](https://github.com/nicknovitski/kernel-fetch_in/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
