current_path = File.expand_path(File.dirname(__FILE__))
$: << File.join(current_path, '..')

require 'lib/lru_cache'

describe LruCache do

  before :each do
    @cache = LruCache.new 3
  end

  describe '#initialize' do
    it 'creates an empty cache' do
      @cache.size.should == 0
      @cache.get('a').should be_nil
    end
  end
 
  it 'updates the LRU item on item creation' do
    @cache.put 'a', 1
    @cache.put 'b', 2
    @cache.put 'c', 3
    @cache.put 'd', 4

    @cache.get('a').should be_nil
    @cache.size.should == 3
  end

  it "updates the LRU item on item 'GET's" do
    @cache.put 'a', 1
    @cache.put 'b', 2
    @cache.put 'c', 3

    @cache.get 'a'
    @cache.put 'd', 4  
    # b gets kicked out
    @cache.get('b').should be_nil

    @cache.get 'c'
    @cache.get 'a'
    @cache.put 'e', 5
    # d gets kicked out
    @cache.get('d').should be_nil
  end

  describe '#put' do
    it 'adds data to the cache' do
      @cache.size.should == 0
      @cache.put('a', 'hello')
      @cache.size.should == 1
    end

    it 'updates data already in the cache' do
      @cache.put('a', 'hello')
      @cache.put('a', 'world')
      @cache.get('a').should == 'world'
    end
  end #put

  describe '#get' do
    it 'returns the cache data' do
      @cache.put('a', 1)
      @cache.get('a').should == 1
    end
  end #get

  describe '#delete' do
    it 'removes items from the cache' do
      @cache.put('a', 1)
      @cache.size.should == 1
      @cache.delete('a')
      @cache.size.should == 0
    end
  end

end
