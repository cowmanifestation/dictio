require './word_finder'
# require 'turn/autorun'
require 'minitest/autorun'
require 'purdytest'

describe WordFinder do
  before do
    @finder = WordFinder.new('./test_list.txt')
  end
  
  describe '#list' do
    it 'returns the contents of a text file' do
      @finder.list.must_equal("abc\nbcd\ncde\ndef\nefg\n\ncherry\napple\narc\ncheese\nache\ngouache\n")
    end
  end

  describe '#begins_with' do
    describe 'with a letter' do
      it "returns all words that begin with supplied letter" do
        @finder.find_words_starting_with('c').must_equal(%w[cde cherry cheese])
      end

      it "should return nothing if there are no matches" do
        @finder.find_words_starting_with('x').must_equal([])
      end
    end

    describe 'with a pattern' do
      it 'returns all words starting with supplied pattern' do
        @finder.find_words_starting_with('bc').must_equal(%w[bcd])
      end
    end
  end

  describe '#find_pattern' do
    it 'returns all of words that contain supplied letter' do
      @finder.find_pattern('c').must_equal(%w[abc bcd cde cherry arc cheese ache gouache])
    end

    it 'returns all of words that contain supplied pattern' do
      @finder.find_pattern('che').must_equal(%w[cherry cheese ache gouache])
    end

    it "should return nothing if there are no matches" do
      @finder.find_pattern('axyz').must_equal([])
    end
  end

  describe '#find_words_containing' do
    it "should return all words containing all supplied letters" do
      @finder.find_words_containing('ca').must_equal(%w[abc arc ache gouache])
    end

    it "should return nothing if there are no matches" do
      @finder.find_words_containing('acx').must_equal([])
    end
  end

  describe '#find_words_ending_with' do
    it "should return all words ending with a certain letter" do
      @finder.find_words_ending_with('e').must_equal(%w[cde apple cheese ache gouache])
    end

    it "should return all words ending with a certain pattern" do
      @finder.find_words_ending_with('he').must_equal(%w[ache gouache])
    end
  end

  # TODO - fix this when I have access to documentation
  # describe '#find_words_without' do
  #   it "should return all words without specified letter" do
  #     @finder.find_words_without('c', 'a').must_equal(%w[bcd cde cherry cheese])
  #   end

  #   it "should work with an empty 'with' pattern" do
  #     @finder.find_words_without('', 'c').must_equal(%w[def efg apple])
  #   end
  # end

  describe '#find_words_of_length' do
    it "should return words of the required length" do
      @finder.find_words_of_length(3).must_equal(%w[abc bcd cde def efg arc])
      @finder.find_words_of_length(6).must_equal(%w[cherry cheese])
      @finder.find_words_of_length(10).must_equal([])
    end
  end

  describe "#find_words_longer_than" do
    it "should return all words at least the specified length" do
      @finder.find_words_longer_than(4).must_equal(%w[cherry apple cheese ache gouache])
    end
  end

  describe "#find_words_shorter_than" do
    it "should return all words of up to specified length" do
      @finder.find_words_shorter_than(4).must_equal(%w[abc bcd cde def efg arc ache])
    end
  end

  describe '#find_words' do
    it "should find words with one supplied parameter" do
      @finder.find_words(:length => 4).must_equal(%w[ache])
    end

    it "should work with two supplied parameters" do
      @finder.find_words(containing: 'ca', ending_with: 'he').must_equal(%w[ache gouache])
    end

    it "should work with 'starting with'" do
      @finder.find_words(:starting_with => 'che').must_equal(%w[cherry cheese])
    end

    it "should work with 'find_pattern'" do
      @finder.find_words(pattern: 'he').must_equal(%w[cherry cheese ache gouache])
    end

    it "should work with 'find_words_containing'" do
      @finder.find_words(containing: 'ca').must_equal(%w[abc arc ache gouache])
    end

    it "should work with 'find_words_ending_with'" do
      @finder.find_words(ending_with: 'e').must_equal(%w[cde apple cheese ache gouache])
    end

    # TODO - fix this when I have access to documentation
    # it "should work with 'find_words_without'" do
    #   @finder.find_words(without: 'e').must_equal(%w[buffaloes])
    # end
    
  end

  ## TODO ##
  # it "should not return words of more than (?) letters" (only a certain number fit on the board)
  # it "should return words in order according to length, shortest first"
  # it "should work with the real list"
end
