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
    # There must be a better way to do this...
    result_list = self.find_pattern(letters.first)
    to_delete = []
    letters[1..-1].each do |l|
      result_list.each do |w|
        unless w =~/#{l}/
          to_delete << w
          # NOT doing this because entries in the array will be skipped due to deletion changing the length:
          # result_list.delete(w)
        end
      end
    end
    to_delete.each {|w| result_list.delete(w)}
    result_list
  end

  def find_pattern_without(pattern, omission)
    p = self.find_pattern(pattern)
    p.reject {|w| w =~ /#{omission}/ || w.empty? }
  end

#  Hmmm...how could this work?
#  def find_pattern(params = {})
#    params[:with]
#    params[:starting_with]
#    params[:containing_letters]
#    params[:without]
#  end
end
