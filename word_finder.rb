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

  def find_words_without(omissions, list = self.list)
    # This may be fine for this situation, 
    # but it could potentially match far more than is desired.
    list.scan(/^[^#{omissions}\n]*$/).delete_if {|e| e.empty? }
  end

  def find_words_of_length(l, list = self.list)
    list.scan(/^\w{#{l}}$/)
  end

  # TODO "#at_least" and "#at_most" methods?
  
  def find_words_longer_than(length, list = self.list)
    list.scan(/^\w{#{length + 1},26}$/)
  end

  def find_words_shorter_than(length, list = self.list)
    list.scan(/^\w{1,#{length - 1}}$/)
  end

  def find_words(params = {})
    results = self.send(find_method(params.first[0]), params.first[1], self.list)
    params.delete(params.first[0])
    
    if results.empty?
      return results
    end

    if params.length > 0
      params.each do |k,v|
        res = self.send(find_method(k), v, results.join("\n"))
        if res.empty?
          return res
        else
          results = res
        end
      end
    end

    results.flatten
  end

  private
    
    def find_method(val)
      self.methods.find {|m| m =~/#{val}/ }
    end
end
