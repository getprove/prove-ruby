
# prove-ruby <sup>0.0.1</sup>

[Prove](https://getprove.com/) API wrapper for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prove'
```

And then execute:

  $ bundle

Or install it yourself:

  $ gem install prove

And require:

```ruby
require 'prove'
```

## Usage

### Quick Start 
```ruby
  #initialize client
  Prove.api_key="test_APIKEY123"

  #get existing verifications
  verifications = Prove::Verification.list

  #create verification
  v = Prove::Verification.create(tel: "1234567890")

  #verify with pin
  v = v.verify(pin: 1337) #or Prove::Verification.verify(id: v.id, pin: 1337)

  #get existing verification
  v = v.retrieve #or Prove::Verification.retrieve(id: v.id) 

  #verification result object
  v.id # "awoeif128912938" 
  v.tel # "1234567890"
  v.text # true
  v.call # false
  v.verified # true

  #create a verification object from scratch
  v = Prove::Verification.new(id: "awoeif128912938, tel:"1234567890", text: true, call: false, verified: true)
```

### Configuration 
Default config
```ruby
  Prove.api_key="test_APIKEY123"
```
Config with options
```ruby
  
  Prove.configure(api_key: "test_APIKEY123", logger: Rails.logger, log_level: :debug, faraday_adapter: :em_http)
```

Advanced config with direct access to faraday connection. (Not recommedended See: [faraday middleware](https://github.com/lostisland/faraday#advanced-middleware-usage))

```ruby
  Prove.configure(api_key: "test_APIKEY123") do |cxn|
        cxn.request  :url_encoded #required
        cxn.response :logger, Rails.logger
        cxn.response :json #required
        cxn.response :raise_error 
        cxn.adapter Faraday.default_adapter
  end
```


### Method Flavors 

Support for either positional params 

```ruby
  Prove::Verification.verify(v.id, 1337)
```

or named params (**recommended**)

```ruby
  Prove::Verification.verify(id: v.id, pin: 1337)
```

## Testing

Install dependencies

```bash
bundle
```

To run tests setup an env variable with your key

```bash
export PROVE=test_APIKEY123
```

and run:

```bash
bundle exec rspec spec
```

or

```bash
PROVE=test_KUrW834WfoDFlNMNN5FC53Z1Xb4 bundle exec rspec spec
```

## Contributors

* Grant Warman <grant.warman@gmail.com>
* Nick Baugh <niftylettuce@gmail.com>


## License

The MIT License

Copyright (c) 2013- Prove <support@getprove.com> (https://getprove.com/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
