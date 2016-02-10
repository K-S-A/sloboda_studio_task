describe 'Integer#factorial', :factorial_task, :factorial do
  subject { rand(1..1000) }

  context 'for 0' do
    it { expect(0.factorial).to eq(1) }
  end

  context 'for negative integers' do
    it { expect((-subject).factorial).to eq(nil) }
  end

  context 'for positive integers' do
    include_examples 'for positive integers' do
      let(:number) { subject.factorial }
    end

    it 'should be divisible without reminder by self base' do
      expect(subject.factorial % subject).to eq(0)
    end

    # get hash from json-file: key - <number>; value - <number>!
    # compare #factorial and known value from hash
    data_from_file('factorials_table').each do |base, value|
      it "for %d should return %E" % [base, value] do
        expect(base.to_i.factorial).to eq(value)
      end
    end

  end

end