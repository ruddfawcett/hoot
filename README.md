# Hoot

This is Hoot!  Hoot is a simple command line tool to alert you when a Terminal process has finished, with a push notification right to your device!

> Hoot! Your process has finished! Come back!

## Installation

Hoot is currently command line only, so you can't use it in your own project.

To install `hoot`, simply execute:

    sudo gem install hoot

## How it Works

Hoot uses a Node.js middleware server that I've dubbed `hedwig`.  Hoot simply posts the email and password you used to sign up in the iOS app -- and sends a notification to that device using Parse.

Because of the current setup Hoot is intended _just_ for a simple computer to iPhone alert, to come back and visit your completed process.

Hedwig is also open source, and can be found at [ruddfawcett/hedwig](https://github.com/ruddfawcett/hedwig).

Hoot may in the future transition over to a `npm` module.

## Usage

Hoot is not very fancy...

When you first install hoot, you will need to authenticate yourself using the email and password you used in the iOS app.

Execute `hoot login`, and you will be prompted to enter your credentials.  To logout, `hoot logout` (you'll still have to remove all traces of Hoot form `~/.netrc`, though your hashed password and email are wiped).

To use, you can do something like the following,

    sh my-long-process.sh && hoot

After your scraping tool/parser/long task has been completed, you'll get an alert on your phone, such as the default message.

> Hoot! Your process has finished! Come back!

If you want to use a custom message, you can use a familiar `git` syntax.

    hoot -m "Your custom message."

## Development

To add features, I'd recommend also using your own branch of `hedwig` ([ruddfawcett/hedwig](https://github.com/ruddfawcett/hedwig)).  You can hack on Hoot with your local copy of Hedwig, and enable development mode using the following:

    DEV=true hoot

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruddfawcett/hoot.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
