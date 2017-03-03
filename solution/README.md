## BarkingMad Demo Gem

A very simple ruby gem.

#### Setup
> Make sure you are inside the `solution` directory!!!

To get up and running you will need to build and install the `barkingmad` gem:

```bash
$ gem build path/to/barkingmad.gemspec
# Successfully built RubyGem
# Name: barkingmad
# Version: 0.0.0
# File: barkingmad-0.0.0.gem

$ gem install ./barkingmad-0.0.0.gem # <-- mind the dot!
# Successfully installed barkingmad-0.0.0
# 1 gem installed
```

> ^^^ Make sure you are inside the `solution` directory!!! ^^^

You should then be able to import/require it in your ruby REPL:

```
$ irb
2.2.5 :001 > require "barkingmad"
 => BarkingMad
2.2.5 :001 > BarkingMad.potato
 => "potato!"
```
