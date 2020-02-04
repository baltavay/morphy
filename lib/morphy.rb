require "dawg"
require_relative "word"

module Morphy

  class Morphy

    def initialize
      @dawg = Dawg.load("#{::Morphy.path}/dawg.bin")
    end

    def query(word)
      entries = @dawg.query(word)

      entries.lazy.map do |row|
        next unless row.present?
        word, para_id, index = row.to_s.split(' ')
        Word.new(word, para_id, index)
      end
    end

    def to_s
      "Morphy"
    end
  end

  extend self

  def new
    Morphy.new
  end

  def path
    File.dirname(__FILE__)+"/dictionary"
  end

  def paradigms
    @@paradigms ||= Marshal.load(File.read("#{path}/paradigms.dat"))
  end

  def prefixes
    @@prefixes ||= File.open("#{path}/prefixes.txt", 'r').read.split("\n")
  end

  def suffixes
    @@suffixes ||= File.open("#{path}/suffixes.txt", 'r').read.split("\n")
  end

  def grammemes
    @@grammemes ||= File.open("#{path}/grammemes.txt", 'r').read.split("\n").map{|g| g.split(",")}
  end

end
