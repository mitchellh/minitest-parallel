# minitest-parallel

This is an extension to [minitest](https://github.com/seattlerb/minitest)
which will run your minitest tests in parallel. It is up to you to ensure
that there is no shared state which can collide.

**WARNING:** This is a _proof of concept_. It works, but is not intended --
in its current form -- to be used for production tests.

## Example

`require` minitest-parallel in your tests:

```ruby
require "minitest/autorun"
require "minitest/parallel"
require "minitest/unit"

class MyTest < MiniTest::Unit::TestCase
  def test_things
    assert true
  end

  def test_other_things
    assert true
  end
end
```

Run them:

    $ ruby my_test.rb
    Started
    .
    Finished in 0.000343 seconds.

    1 tests, 1 assertions, 0 failures, 0 errors, 0 skips

TODO
