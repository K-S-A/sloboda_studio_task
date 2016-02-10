describe Braces, :braces_task do
  subject { Class.new.extend(Braces) }

  it { expect(subject).to respond_to(:correct_combinations) }
  
  context '#correct_combinations' do
    
    it 'should call block_given?' do
      expect(Object).to receive(:block_given?)
      subject.correct_combinations(1)
    end

    context 'when block given' do
      # get hash from json-file: key - <argument>; value - <sequence of arguments to yield>
      # .data_from_file() - helper method (from Helper module)
      yield_data = data_from_file('braces_data')

      include_examples "for yield times results", yield_data
      include_examples "for yield with arguments results", yield_data.select{ |k, _| k < '5' }
    end

    context 'when called without arguments' do
      it { expect{ subject.correct_combinations }.to raise_error(ArgumentError) }
    end

    # get hash from json-file: key - <context_name>; value - <arguments for examples>
    # .data_from_file() - helper method (from Helper module)
    data_from_file('braces_arguments_data').each do |cont_name, args|
      context "#{cont_name}" do
        include_examples "for not permitted arguments", *args.first
        include_examples "for permitted arguments", *args.last
      end
    end

  end

end