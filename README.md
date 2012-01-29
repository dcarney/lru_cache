## About
A dead-simple LRU (Least Recently Used) cache implementation in Ruby.

This cache has a fixed size with respect to the number of items it holds.
It supports the 3 self-explanatory methods: #put, #get and #delete.

Once the cache is full, storing any new items will result in the Least
Recently Used (LRU, get it?) item getting removed from the cache.

## Dependencies 
None, unless you want to run the tests.  If you do, just install rspec, and you're set:

    $ gem install rspec

This code was written/tested using ruby 1.9.3. YMMV with other versions.

## Running the tests
	# Install required gems
	$ gem install rspec

    # run tests
    $ rspec spec