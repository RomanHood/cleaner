# cleaner
Clean nested repeated fields from a JSON document.

This repository features a couple different solutions to the challenge.
First I quickly wrote a little ad-hoc script implementation that satisfied the
example from your email.

But to ensure the solution contiues to work even with deeper-nested data I chose
to implement a more structured, object-oriented approach.

To download this repository:

```shell
git clone git@github.com:RomanHood/cleaner.git
cd cleaner
```
First run `bundle install` from your shell. This will enable you to run guard,
if you would like to, and enable pretty-looking output from the scipt
implementation.

To run the script:
```shell
ruby script/ad_hoc.rb
```
To test the more mature implementation run:
```shell
rspec
```
Or
```shell
rspec spec/lib
```
From inside the project root directory. Either option will work just fine.

The code for this project lives in `<root>/lib/cleaner.rb`
