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

  def find_words_containing(letters)
    letters = letters.split('')
    result_list = self.find_pattern(letters.first)

    letters[1..-1].each do |l|
      result_list.reject! {|w| w !~ /#{l}/ }
    end
    result_list
  end

  def find_words_ending_with(pattern)
    self.list.scan(/\w*#{pattern}$/)
  end

  def find_words_without(pattern, omission)
    p = self.find_pattern(pattern)
    p.reject {|w| w =~ /#{omission}/ || w.empty? }
  end

#  Hmmm...how could this work?
#  def find_pattern(params = {})
#    params[:with]
#    params[:starting_with]
#    params[:containing_letters]
#    params[:without]
#    params[:length]
#  end
end
