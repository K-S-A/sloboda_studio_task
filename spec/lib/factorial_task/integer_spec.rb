describe Integer, :factorial_task, :integer do
  subject { rand(1..1000) }

  it { expect(subject).to be_kind_of(Integer) }
  it { expect(subject).to respond_to(:factorial) }
  it { expect(subject).to respond_to(:sum_digits) }
end
