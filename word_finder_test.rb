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
  end

  ## TODO ##
  # it "should return all words starting with the pattern"
  # it "should return all words containing all supplied letters"
  # it "should return words in order according to length, shortest first"
end
