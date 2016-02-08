shared_examples "for positive integers" do
  it { expect(number).not_to be_nil }
  it { expect(number).to be_kind_of(Integer) }
  it { expect(number).to be > 0 }
end