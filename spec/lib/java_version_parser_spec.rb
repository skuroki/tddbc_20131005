require 'java_version_parser'

describe JavaVersionParser do
  describe '.judge_validity' do
    specify { JavaVersionParser.judge_validity("JDK7u40").should be_true }
    specify { JavaVersionParser.judge_validity("JDK740").should be_false }
    specify { JavaVersionParser.judge_validity("JDK7u").should be_false }
  end
end
