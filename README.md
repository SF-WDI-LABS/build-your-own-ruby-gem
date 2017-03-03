# Build Your Own Ruby Gem

<img src="https://media.giphy.com/media/Pfk07Wol1AeD6/giphy.gif" width="200px">

In this lab we will be exploring the ruby CLI and the concept of a ruby "library" or "gem".

> This tutorial assumes you have [ruby, gem, and bundler installed](https://github.com/SF-WDI-LABS/installfest/blob/master/environment-setup/ruby-on-rails-stack.md) on your computer.

## The `irb` or `pry` REPL
"R.E.P.L." stands for "Read Evaluate Print Loop". The Chrome Javascript Console is an example of a REPL.

From the command line, type `irb` (or `pry`). This will launch the ruby REPL. Type `exit` to quit.

```
$ irb

2.2.5 :001> 1 + 1
 => 2 
2.2.5 :002> "hello" + "world"
 => "helloworld"
2.2.5 :003> exit
```

> Note that `2.2.5` indicates the ruby version. `001` means we're on line #1 of this REPL session.

The keyboard shortcut `ctrl+c` is your friend! Ruby will *only* evaluate syntactically correct code (e.g. all your brackets/quotes match). If you forgot to close a quote, you will see `"` when you hit enter. Here are your options:
- Hit `ctrl+c` to start over if the mistake in on the line above.
- If your current code is correct, keep typing and complete your thought.

```
$ irb

2.2.5 :001 > vegetable = "potato
2.2.5 :002">                     # Uh oh! You left a quote open. Hit ctrl+c to start over!
2.2.5 :003 >
2.2.5 :004 > def good
2.2.5 :005?>    "yay"            # <-- note the `?`
2.2.5 :006?> end                 # <-- note the `?`
 => :good                        #     Nice! It worked.
2.2.5 :007 > good
 => "yay"
2.2.5 :008 > exit
```

## Getting Fancy with Gems
The core ruby library has a lot of cool features, but it doesn't do everything. When we want more powerful tools, or have a domain-specific problem, we generally get help from third-party libraries and frameworks.

> Jargon Note: The words "Gem" and "Library" are used interchangably.

For example the gem [ffaker](https://rubygems.org/gems/ffaker) has a bunch of convenience methods that make generating fake data easier.

Using the ffaker [`FFaker::Name.first_name`](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md#ffakername) method we can generate a random first name like `"Melinda"` or `"Gary"`.

We can install the `ffaker` gem on our system by typing:

```bash
gem install ffaker
```

Then, we can require/import the ffaker library into our ruby REPL (`irb`, `pry`):

```
2.2.5 :001 > FFaker                         # Uh Oh! We haven't required it yet!
NameError: uninitialized constant FFaker    # k, thx!
2.2.5 :002 > require "ffaker"
 => true                                    # nice! It worked!
2.2.5 :003 > FFaker::Name.first_name
 => "Gary"
2.2.5 :004 > FFaker::Name.first_name
 => "Sybil"
```

**Exercise**: Take a moment to explore the [FFaker::Name Reference](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md#ffakername). Can you generate random names with titles, like "Dr. Gary W. Bernard", and "Mrs. Sybil B. Pitts"? What about random email addresses?


## Using Gems in Your Projects
To use gems in our ruby projects, we need to list our dependencies and indicate their version numbers. That way other developers can download our code and get up and running quickly.

For starters, let's create a new project called `barkingmad` with the following folder structure:

```
barkingmad/           // <-- project folder
├── lib/
│   └── barkingmad.rb // <-- main entry point
├── README.md
└── ...
```

Add the following code to `barkingmad.rb`:

```ruby
# /lib/barkingmad.rb

require 'ffaker'

class BarkingMad
  def self.potato
    "potato!"
  end
end

p BarkingMad.potato
p "Random name: #{ FFaker::Name.name }"
p "Random email: #{ FFaker::Internet.email }"
```

Now execute your code using the command: `ruby path/to/barkingmad.rb`. You should see a random name and email printed to your terminal.

(STOP and COMMIT)

**BUT WAIT!** How will other developers know that my code depends on the ffaker gem, specifically version 2.5? We need a `Gemfile`!

To generate a `Gemfile`, from the root of your project directory run the following command:

```bash
$ bundle init
```

```
barkingmad/           // <-- project folder
├── Gemfile           // <-- dependencies
├── lib/
│   └── barkingmad.rb // <-- main entry point
├── README.md
└── ...
```

Open `Gemfile` in your editor and add `ffaker` as a dependency:

```
source "https://rubygems.org"

gem "ffaker"
```

Next, run `bundle` or `bundle install` to generate/update your `Gemfile.lock`.

Take a peek and you'll see something roughly similar to the follow:
```
GEM
  remote: https://rubygems.org/
  specs:
    ffaker (2.5)

PLATFORMS
  ruby

DEPENDENCIES
  ffaker

BUNDLED WITH
   1.14.5

```

> **Pro-Tip**: NEVER EVER ever modify your `Gemfile.lock` file directly! (Why do you think that is?)

(STOP and COMMIT)

## Building Your Own Gem
How cool would it be if our `barkingmad` project were an actual gem that we could require and use in our projects locally?

```
# ** MAGICAL WORLD IN WHICH THIS WORKS **
2.2.5 :001 > require "barkingmad"
 => BarkingMad
2.2.5 :002 > BarkingMad.potato
 => "potato!"
 # ** MAGICAL WORLD IN WHICH THIS WORKS **
```

To make this work, we need to make a fancy `barkingmad.gemspec` file in the root of our project directory that describes some metadata about the project, like so:

```
barkingmad/
├── barkingmad.gemspec  // <-- add this file
├── Gemfile
├── lib/
│   └── barkingmad.rb
├── README.md
└── ...
```

```ruby
# barkingmad.gemspec
Gem::Specification.new do |s|
  s.name        = 'barkingmad'
  s.version     = '0.0.0'
  s.date        = '1999-12-31'
  s.summary     = "Bark!"
  s.description = "A fancy barkinmad gem"
  s.authors     = ["Suzy Sue"]
  s.email       = 'suzy@sue.net'
  s.files       = ["lib/barkingmad.rb"]
  s.homepage    = 'https://suzyworld.net'
  s.license       = 'MIT'
  s.add_dependency "ffaker", "~> 2.5"
end
```

We also need to modify our old `Gemfile` to point to this new `barkingmad.gemspec` file. Here's what the updated `Gemfile` should look like:

```ruby
source 'https://rubygems.org'

# Specify your gem's dependencies in potato.gemspec
gemspec
```

Now let's build our gem and install it (you will need to do this frequently)!

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

Now we can jump into our ruby REPL and give it a shot:
```
$ irb
2.2.5 :001 > require "barkingmad"
 => true
2.2.5 :002 > BarkingMad.potato
 => "potato!"
```


**Keep in Mind**: You can still use the `ruby path/to/barkingmad.rb` command. And the old way of "loading" ruby code into your REPL stills works as well.

```
$ irb
2.2.5 :001 > load "path/to/barkingmad.rb"
=> true
```


But if you want to be able to type just `require "barkingmad"` *you will need to re-`build` and re-`install` your gem __every time__* you make a change to it.

> **Watch Out**: the command `load` is very different from `require`!

## Exercise - [solution](solution)

Can you extend `BarkingMad` to work in the following way:

```
2.2.5 :001 > require "barkingmad"
 => true
2.2.5 :002 > human1 = BarkingMad.random_new_human
2.2.5 :003 > human1.country
 => "Albania"
2.2.5 :004 > human1.greet
 => "Hi, my name is Dr. Who"
2.2.5 :005 > human2 = BarkingMad.random_new_human
2.2.5 :006 > human2.first_name
 => "Alice"
2.2.5 :007 > human1.greet(human2)
 => "Hi Alice, my name is Dr. Who"
```

> **Hint**: The code outlined above assumes you're approaching this problem using Object Orientation (classes)!

## Resources
* [Bundler and the `Gemfile`](http://bundler.io/v1.14/gemfile.html)
* [RubyGems Guide to Making a Gem](http://guides.rubygems.org/make-your-own-gem/)
* [Using Bundler to create a skeleton gem](http://bundler.io/v1.14/guides/creating_gem.html) [Advanced]
