# HexletCode

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code

## Usage

```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

HexletCode.form_for user do |f|
  f.input :name, class: 'text-input'
  f.input :job, as: :text
  f.input :gender, as: :select, collection: %w[m f]
  f.submit
end
```

will generate

```html
<form action="#" method="post">
  <label for="name">Name</label>
  <input type="text" name="name" value="rob" class="text-input" />
  <label for="job">Job</label>
  <textarea name="job" cols="20" rows="40">hexlet</textarea>
  <label for="gender">Gender</label>
  <select name="gender">
    <option value="m" selected>m</option>
    <option value="f">f</option>
  </select>
  <input type="submit" name="commit" value="Save" />
</form>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To run tests use `rake spec`
