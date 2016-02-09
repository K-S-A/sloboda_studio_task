require_relative 'spec_helper'

describe Integer do
  subject { rand(1..1000) }

  it { expect(subject).to be_kind_of(Integer) }
  it { expect(subject).to respond_to(:factorial) }
  it { expect(subject).to respond_to(:sum_digits) }
  
  context '#factorial' do
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

      # from json-file get hash: key - <number>; value - <number>!
      file = File.read("#{File.dirname(__FILE__)}/data/factorials_table.json")
      
      # compare #factorial and known value from hash
      JSON.parse(file).each do |base, value|
        it "for %d should return %E" % [base, value] do
          expect(base.to_i.factorial).to eq(value)
        end
      end

    end

    context '#sum_digits' do
      it 'should return 0 only for 0' do
       expect(0.sum_digits).to eq(0)
      end
      it 'should not depend on count and order of zeros' do
        expect(101010.sum_digits).to eq(110001.sum_digits)
      end
      it 'should change result by value of appended digit' do
        number = subject * 10 + rand(10)
        expect(number.sum_digits - subject.sum_digits).to eq(number % 10)
      end

      context 'if number contains one repeating numeral' do
        it 'should return its value times length of the number' do
          numeral = rand(1..9)
          number = (numeral.to_s * rand(1..99)).to_i
          expect(number.sum_digits).to eq(numeral * number.to_s.length)
        end
      end

      context 'for non-zero integers' do
        include_examples 'for positive integers' do
          let(:number) { subject.sum_digits }
        end
      end
      
      context 'should return different results for' do
        it 'numbers with different sum of digits' do
          expect(1111.sum_digits).not_to eq(9999.sum_digits)
        end
      end

      context 'should return equal results for' do
        it 'equal numbers' do
          expect(subject.sum_digits).to eq(subject.sum_digits)
        end
        it 'numbers with equal absolute values' do
          expect(-55.sum_digits).to eq(55.sum_digits)
        end
        it 'numbers with the same set of digits' do
          expect(123456.sum_digits).to eq(456321.sum_digits)
        end
      end

      context 'if number contains one digit' do
        it 'should return that number' do
          number = rand(10)
          expect(number.sum_digits).to eq(number)
        end
      end

    end

  end

end
