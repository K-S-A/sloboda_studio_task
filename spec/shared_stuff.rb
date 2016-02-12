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

# for cities_spec

shared_examples 'initialized with' do |*arguments|
  arguments.each do |argument|
    it "should be initialized with #{argument.class}" do
      expect { Cities.new(argument) }.not_to raise_error
    end
  end
end

shared_examples 'for valid args' do |method, *arguments|
  arguments.each do |arg|
    it "should be called with (#{arg.join(', ')})" do
      expect { subject.public_send(method, *arg) }.not_to raise_error
    end
  end
end

shared_examples 'for invalid args' do |method, *arguments|
  arguments.each do |arg|
    it "should raise ArgumentError if called with (#{arg.join(', ')})" do
      expect { subject.public_send(method, *arg) }.to raise_error(ArgumentError)
    end
  end
end

shared_examples 'arguments check for' do |method|
  context 'when called without arguments' do
    it { expect { subject.public_send(method) }.to raise_error(ArgumentError) }
  end

  context 'when called with one argument' do
    it do
      expect { subject.public_send(method, 1) }.to raise_error(ArgumentError)
    end
  end

  context 'when called with two arguments' do
    context 'that are included in subjects#map (index or name of city)' do
      include_examples 'for valid args', method, [1, 2], [3, 'gdansk'],
                       ['torun', 1], %w(warszawa bydgoszcz)
    end

    context 'that are out of subjects#map (index or name of city)' do
      include_examples 'for invalid args', method, [9, 2], [3, 'paris'],
                       ['torun', 7]
    end
  end
end

shared_examples 'return values for' do |method, arguments|
  arguments.each do |arg, res|
    it "should return #{res} if called with (\"#{arg.join('", "')}\")" do
      expect(subject.public_send(method, *arg)).to eq(res)
    end
  end
end
