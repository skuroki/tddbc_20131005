class JavaVersionParser
  def self.judge_validity(source)
    /^JDK\d+u\d+$/ === source
  end
end
