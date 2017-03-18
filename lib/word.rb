module Morphy
  class Word
    attr_accessor :para_id

    def initialize(word,para_id,index)
      @word = word
      @para_id = para_id.to_i
      @index = index.to_i
      @prefix_id = ::Morphy.paradigms[@para_id][@index * 3]
      @suffix_id = ::Morphy.paradigms[@para_id][@index * 3 + 1]
      @grammeme_id = ::Morphy.paradigms[@para_id][@index * 3 + 2]
    end

    def to_s
      @word
    end

    def normal_form
      prefix = ::Morphy.prefixes[::Morphy.paradigms[@para_id][0]]
      suffix = ::Morphy.suffixes[::Morphy.paradigms[@para_id][1]]
      "#{prefix}#{stem}#{suffix}"
    end

    def grammemes
      ::Morphy.grammemes[@grammeme_id]
    end

    def stem      
      word = @word.dup
      word.sub!(::Morphy.prefixes[@prefix_id], '')
      word = word.reverse.sub(::Morphy.suffixes[@suffix_id].reverse, '').reverse
      word
    end

    def same_paradigm?(other)
      @para_id == other.para_id
    end

    def tag
      ::Morphy.grammemes[@grammeme_id].join(',')
    end

    def lexemme
      (0..(::Morphy.paradigms[@para_id].length / 3) - 1).map do |index|
        prefix = ::Morphy.prefixes[::Morphy.paradigms[@para_id][index * 3]]
        suffix = ::Morphy.suffixes[::Morphy.paradigms[@para_id][index * 3 + 1]]
        grammeme = ::Morphy.grammemes[::Morphy.paradigms[@para_id][index * 3 + 2]]
        Word.new(prefix + stem + suffix, @para_id, index)
      end
    end

    def inflect(grammemes)
      words = lexemme
      words.each do |word|
        return word if (word.grammemes & grammemes).length == grammemes.length
      end
      nil
    end
  end
end
