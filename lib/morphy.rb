require "dawg"

class Morphy
  class Word
    attr_accessor :para_id
    
    def initialize(word,para_id,index)
      @word = word
      @para_id = para_id.to_i
      @index = index.to_i
      @prefix_id = Morphy.paradigms[@para_id][@index*3]
      @suffix_id = Morphy.paradigms[@para_id][@index*3+1]
      @grammeme_id = Morphy.paradigms[@para_id][@index*3+2]
      
    end
    
    def to_s
      @word      
    end
    
    def normal_form
      prefix = Morphy.prefixes[Morphy.paradigms[@para_id][0]]
      suffix = Morphy.suffixes[Morphy.paradigms[@para_id][1]]      
      
      "#{prefix}#{stem}#{suffix}"
    end
    def grammemes
      Morphy.grammemes[@grammeme_id]      
    end
    def stem
      prefix = Morphy.prefixes[Morphy.paradigms[@para_id][0]]
      suffix = Morphy.suffixes[Morphy.paradigms[@para_id][1]]
      grammeme = Morphy.grammemes[Morphy.paradigms[@para_id][2]]
      word = @word.dup
      word.sub!(Morphy.prefixes[@prefix_id],"")
      word = word.reverse.sub(Morphy.suffixes[@suffix_id],"").reverse
      word
    end

    def same_paradigm?(other)
      @para_id == other.para_id      
    end

    def tag
      Morphy.grammemes[@grammeme_id].join(",") 
    end

    def lexemme
      (0..(Morphy.paradigms[@para_id].length / 3)-1).map do |index|        
        prefix = Morphy.prefixes[Morphy.paradigms[@para_id][index*3]]
        suffix = Morphy.suffixes[Morphy.paradigms[@para_id][index*3+1]]
        grammeme = Morphy.grammemes[Morphy.paradigms[@para_id][index*3+2]]
        Word.new(prefix+stem+suffix,@para_id,index)
      end      
    end

    def inflect(grammemes)
      words = lexemme
      words.each do |word|
        return word if word.grammemes.last(grammemes.length) == grammemes
      end
      nil
    end      
  end
  def initialize    
    
    path = File.dirname(__FILE__)+"/dictionary/"

    @dawg = Dawg.load("#{path}/dawg.dat") # why it's eating so much memory?
    @@suffixes ||= File.open("#{path}/suffixes.txt", 'r').read.split("\n")
    @@prefixes ||= File.open("#{path}/prefixes.txt", 'r').read.split("\n")
    @@grammemes ||= File.open("#{path}/grammemes.txt", 'r').read.split("\n").map{|g| g.split(",")}    
    @@paradigms ||= Marshal.load(File.read("#{path}/paradigms.dat"))
  end
  def self.paradigms
    @@paradigms    
  end
  def self.prefixes
    @@prefixes    
  end
  def self.suffixes
    @@suffixes
  end
  def self.grammemes
    @@grammemes    
  end
  def find_similar(word)
    results = @dawg.find_similar(word)
    results = results.map do |result|
      word,para_id,index = result.split(" ")
      Word.new(word,para_id,index)
    end
    results
  end
  def to_s
    "Morphy"    
  end
end