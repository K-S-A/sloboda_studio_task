describe Braces, :braces_task do
  subject { Class.new.extend(Braces) }
  let(:call_combinations) { subject.combinations(1) {} }

  it { expect(subject).to respond_to(:combinations) }

  context '#combinations' do
    it 'should not call block_given?' do
      expect(subject).not_to receive(:block_given?)
      call_combinations
    end

    it 'should initiate recursive call' do
      # array of arguments in order to be called
      [[1], [1, '(', 1, 0], [1, '()', 1, 1]].each do |args|
        expect(subject).to receive(:combinations).with(*args)
          .and_call_original
          .ordered
      end

      call_combinations
    end

    context 'when block given' do
      # get hash from json-file:
      # key - <argument>; value - <sequence of arguments to yield>
      # .data_from_file() - helper method (from Helpers module)
      yield_data = data_from_file('braces_data')

      include_examples 'for yield times results', yield_data
      include_examples 'for yield with arguments results',
                       yield_data.select { |k, _| k < '5' }
    end

    context 'when called without arguments' do
      it do
        expect { subject.combinations }.to raise_error(ArgumentError)
      end
    end

    # get hash from json-file:
    # key - <context_name>; value - <arguments for examples>
    # .data_from_file() - helper method (from Helper module)
    data_from_file('braces_arguments_data').each do |cont_name, args|
      context cont_name.to_s do
        include_examples 'for not permitted arguments', *args.first
        include_examples 'for permitted arguments', *args.last
      end
    end
  end
end
