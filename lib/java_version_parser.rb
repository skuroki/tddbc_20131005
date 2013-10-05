class JavaVersionParser
  PATTERN = /^JDK(\d+)u(\d+)$/
  class InvalidSource < StandardError; end

  class << self
    def judge_validity(source)
      PATTERN === source
    end

    def parse(source)
      m = PATTERN.match(source)
      raise InvalidSource if m.nil?
      Result.new(m[1].to_i, m[2].to_i)
    end
  end

  class Result < Struct.new(:family_number, :update_number)
    include Comparable
    def <=>(other)
      (self.family_number <=> other.family_number).nonzero? || self.update_number <=> other.update_number
    end
  end
end
