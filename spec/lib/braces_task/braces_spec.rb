describe Braces do
  subject { Class.new.extend(Braces) }

  it { expect(subject).to respond_to(:correct_combinations) }
  
  context '#correct_combinations' do
    
    it 'should call block_given?' do
      expect(Object).to receive(:block_given?)
      subject.correct_combinations(1)
    end

    context 'when block given' do
      data_file = File.read("#{File.dirname(__FILE__)}/../support/braces_data.json")
      
      include_examples "for yield times results", JSON.parse(data_file)
    end

    context 'when called without arguments' do
      it { expect{ subject.correct_combinations }.to raise_error(ArgumentError) }
    end

    context 'when first argument' do
      include_examples "for not permitted arguments", ['123', nil, true, false, :symbol], []
      include_examples "for permitted arguments", [1], []
    end

    context 'when second argument' do
      include_examples "for not permitted arguments", [1, nil, true, false, :symbol], [1]
      include_examples "for permitted arguments", ['', '('], [1]
    end

    context 'when third argument' do
      include_examples "for not permitted arguments", ['123', nil, true, false, :symbol], [1, '']
      include_examples "for permitted arguments", [0, 1], [1, '']
    end

    context 'when fourth argument' do
      include_examples "for not permitted arguments", ['123', nil, true, false, :symbol], [1, '', 1]
      include_examples "for permitted arguments", [0, 1], [1, '', 1]
    end

  end

end