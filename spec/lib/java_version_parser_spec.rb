require 'java_version_parser'

describe JavaVersionParser do
  describe '.judge_validity' do
    specify { JavaVersionParser.judge_validity("JDK7u40").should be_true }
    specify { JavaVersionParser.judge_validity("JDK740").should be_false }
    specify { JavaVersionParser.judge_validity("JDK7u").should be_false }
    specify { JavaVersionParser.judge_validity("JDK7u9x").should be_false }
  end

  describe '.parse' do
    specify 'returns instance which knows family number and update number' do
      v = JavaVersionParser.parse("JDK7u40")
      v.family_number.should == 7
      v.update_number.should == 40
    end

    specify 'raises when invalid source given' do
      expect { JavaVersionParser.parse("JDK7u9x") }.to raise_error JavaVersionParser::InvalidSource
    end
  end
end
