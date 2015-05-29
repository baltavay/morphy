# morphy
Morphological analyzer (POS tagger + inflection engine) for Russian language in ruby. Inspired by pymorphy2

## Installation

Add this line to your application's Gemfile:

    gem 'morphy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install morphy

## Usage
    # Words must be added in alphabetical order
    require "morphy"
    
    morphy = Morphy.new
    
    word = morphy.find_similar("облако").first

    datv = word.inflect(["datv"])
    datv.to_s
    => облаку
    datv.inflect(["nomn"]).to_s
    => облако
    datv.lexemme.map(&:to_s)
    => ["облако", "облака", "облаку", "облако", "облаком", "облаке", "облака", "облаков", "облакам", "облака", "облаками", "облаках"]
    datv.normal_form
    => облако



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

