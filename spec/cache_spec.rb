current_path = File.expand_path(File.dirname(__FILE__))
$: << File.join(current_path, '..')

require 'lib/lru_cache'

describe LruCache do

  before :each do
    @cache = LruCache.new 5
  end

  describe '#initialize' do
    it 'creates an empty cache' do
      @cache.size.should == 0
      @cache.get('123').should be_nil
    end
  end
 
  it 'kicks out the LRU item' do
    @cache.put 'a', 1
    @cache.put 'b', 2
    @cache.put 'c', 3
    @cache.put 'd', 4
    @cache.put 'e', 5
    @cache.put 'f', 6

    @cache.get('f').should == 6
    @cache.get('b').should == 2
    @cache.get('a').should be_nil
    @cache.size.should == 5
  end

  it 'kicks out the LRU item' do
    @cache.put 'a', 1
    @cache.put 'b', 2
    @cache.put 'c', 3
    @cache.put 'd', 4
    @cache.put 'e', 5

    @cache.get 'a'
    @cache.put 'f', 6  
    # b should have ben kicked out
    @cache.get('b').should be_nil
  end

  describe "#get" do
    it 'returns the cache data' do
      @cache.put('a', 1)
      @cache.get('a').should == 1
    end

  end #get

end
