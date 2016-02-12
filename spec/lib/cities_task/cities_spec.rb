describe Cities, :cities_task do
  subject { Cities.new(cities_hash) }

  include_examples 'initialized with', {}, cities_data_file
  it 'should define instance variable @map' do
    expect(subject.instance_variable_defined?(:@map)).to be_truthy
  end
  it { expect(subject).to be_kind_of(Cities) }
  it { expect(subject).to respond_to(:cheapest_cost) }
  it { expect(subject).to respond_to(:cheapest_path) }
  it { expect(subject).to respond_to(:map) }

  context 'when initialized without arguments' do
    it { expect { Cities.new }.to raise_error(ArgumentError) }
  end

  context '#map' do
    let(:cities_array) { subject.map.values.collect { |c| c[:name] } }

    it 'should return Hash' do
      expect(subject.map).to be_kind_of(Hash)
    end
    it 'should contain indexes of cities as a keys' do
      expect(subject.map.keys).to eq([1, 2, 3, 4])
    end
    it 'should contain names of cities' do
      expect(cities_array).to eq(%w(gdansk bydgoszcz torun warszawa))
    end
    it 'should store connections between cities' do
      expect(subject.map.values.all? { |i| i.key?(:conns) }).to be_truthy
    end
  end

  context '#cheapest_cost' do
    it 'should return Integer value' do
      expect(subject.cheapest_cost(1, 2)).to be_kind_of(Integer)
    end

    include_examples 'arguments check for', :cheapest_cost
    include_examples 'return values for', :cheapest_cost, test_hash(0)
  end

  context '#cheapest_path' do
    it 'should return Array' do
      expect(subject.cheapest_path(1, 2)).to be_kind_of(Array)
    end

    include_examples 'arguments check for', :cheapest_path
    include_examples 'return values for', :cheapest_path, test_hash(1)
  end
end
