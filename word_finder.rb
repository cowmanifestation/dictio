class WordFinder
  def initialize(list = './enable1_unix.txt')
    @list = list
  end
  
  def list
    File.read(@list)
  end

  def find_words_starting_with(pattern, list = self.list)
    list.scan(/^#{pattern}\w*$/)
  end

  def find_pattern(pattern, list = self.list)
    list.scan(/^\w*#{pattern}\w*/)
  end

  def find_words_containing(letters, list = self.list)
    letters = letters.split('')
    result_list = self.find_pattern(letters.first, list)

    letters[1..-1].each do |l|
      result_list.reject! {|w| w !~ /#{l}/ }
    end
    result_list
  end

  def find_words_ending_with(pattern, list = self.list)
    list.scan(/\w*#{pattern}$/)
  end

  def find_words_without(pattern, omission, list = self.list)
    p = self.find_pattern(pattern, list)
    p.reject {|w| w =~ /#{omission}/ || w.empty? }
  end

  # There must be a better way to do this:
  # You have to enter a blank options hash in order to enter an alternate list.
  def find_words_of_length(l, list = self.list) # options = {},
    list.scan(/^\w{#{l}}$/)
  end

  def find_words_longer_than(length)
    list.scan(/^\w{#{length},26}$/)
  end

  def find_words_shorter_than(length, list = self.list)
    list.scan(/^\w{1,#{length}}$/)
  end

  def find_words(params = {})
    results = []
    params.each do |k,v|
      if results.empty?
        results << self.send(find_method(k), v, self.list)
      else
        results = self.send(find_method(k), v, results.join("\n"))
      end
    end
    results.flatten
  end

  private
    
    def find_method(val)
      self.methods.find {|m| m =~/#{val}/ }
    end
end
