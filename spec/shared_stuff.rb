# for factorial_spec

shared_examples 'for positive integers' do
  it { expect(number).not_to be_nil }
  it { expect(number).to be_kind_of(Integer) }
  it { expect(number).to be > 0 }
end

# for braces_spec

shared_examples 'for not permitted arguments' do |arguments, defined_args|
  arguments.each do |arg|
    it "should raise ArgumentError if argument is a #{arg.inspect}" do
      expect do
        subject.combinations(*defined_args, arg)
      end.to raise_error(ArgumentError)
    end
  end
end

shared_examples 'for permitted arguments' do |arguments, defined_args|
  arguments.each do |arg|
    it "should not raise error if argument is a #{arg.inspect}" do
      expect do
        subject.combinations(*defined_args, arg) {}
      end.not_to raise_error
    end
  end
end

shared_examples 'for yield times results' do |arguments|
  arguments.each do |argument, sequence|
    it "should yield #{sequence.length} times if called with (#{argument})" do
      expect do |b|
        subject.combinations(argument.to_i, &b)
      end.to yield_control.exactly(sequence.length).times
    end
  end
end

shared_examples 'for yield with arguments results' do |arguments|
  arguments.each do |argument, sequence|
    it "should yield with arguments #{sequence} if called with (#{argument})" do
      expect do |b|
        subject.combinations(argument.to_i, &b)
      end.to yield_successive_args(*sequence)
    end
  end
end
