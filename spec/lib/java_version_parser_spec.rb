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

  describe '::Result' do
    describe 'comparisons' do
      let(:u40) { JavaVersionParser.parse("JDK7u40") }
      let(:u51) { JavaVersionParser.parse("JDK7u51") }
      let(:jdk8u0) { JavaVersionParser.parse("JDK8u0") }

      specify { u40.should < u51 }
      specify { u51.should > u40 }
      specify { u51.should < jdk8u0 }
      specify { jdk8u0.should > u51 }
      specify { u40.should < jdk8u0 }
      specify { jdk8u0.should > u40 }
      specify { u40.should == u40 }
      specify { u51.should == u51 }
      specify { jdk8u0.should == jdk8u0 }
    end

    describe '#next_limited_update' do
      context 'when update number is 45' do
        let(:u45) { JavaVersionParser.parse("JDK7u45") }

        subject { u45.next_limited_update }

        it { should_not == u45 }
        its(:family_number) { should == 7 }
        its(:update_number) { should == 60 }
      end

      context 'when update number is 60' do
        let(:u60) { JavaVersionParser.parse("JDK7u60") }

        subject { u60.next_limited_update }

        it { should_not == u60 }
        its(:family_number) { should == 7 }
        its(:update_number) { should == 80 }
      end
    end
  end
end
