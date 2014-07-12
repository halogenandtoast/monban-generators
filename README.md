# Monban::Generators

Rails generators for adding in authentication components, using the
[Monban](https://github.com/halogenandtoast/monban) authentication library.

## Installation

Add this line to your application's Gemfile:

    gem 'monban-generators'

And then execute:

    $ bundle

## Generators

Currently there are two generators available, but over time more will be added:

### Scaffold

You can generate a basic starting point for any monban app by running the following:

    rails g monban:scaffold

### Password Reset

If you'd like to generate basic password reset for your app, you can run:

    rails g monban:password_reset

This will generate the necessary files for an implementation of resetting
a user's password. It will ask you for host names for development, test
and production environments in order to make the mailer work.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/monban-generators/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
