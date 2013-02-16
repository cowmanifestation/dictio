class WordFinder
  def initialize(list = './enable1_unix.txt')
    @list = list
  end
  
  def list
    File.read(@list)
  end

  def find_words_starting_with(pattern)
    self.list.scan(/^#{pattern}\w*$/)
  end

  def find_pattern(pattern)
    self.list.scan(/^\w*#{pattern}\w*/)
  end
end
