# minitest-parallel

This is an extension to [minitest](https://github.com/seattlerb/minitest)
which will run your minitest tests in parallel. It is up to you to ensure
that there is no shared state which can collide.

This code is pretty much identical at the moment to ngauthier's
[minitest-parallel](https://github.com/ngauthier/minitest-parallel) project.
I needed to make some quick changes to get it working for a talk, so I
cloned and pushed instead. But props to him!

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
    puts "test_things"
    sleep 2
    assert true
  end
end

class AnotherTest < MiniTest::Unit::TestCase
  def test_other_things
    puts "test_other_things"
    sleep 2
    assert true
  end
end
```

Run them:

    $ ruby my_test.rb
    # Running tests:

    test_things
    test_other_things
    ..

    Finished tests in 2.081270s, 0.9610 tests/s, 0.9610 assertions/s.

    2 tests, 2 assertions, 0 failures, 0 errors, 0 skips

Notice that although both tests have a `sleep` in them, they ran in parallel.
By default `minitest/parallel` will run the number of processes equal to your
cores.
