# ./spec/my_enumerables_spec.rb

require 'rspec'
require_relative '../enumerables'

RSpec.describe 'Enumerable Module' do
  let(:array) { Array.new(15) { rand(1...30) } }
  let(:array_reverse) { array.reverse }
  let(:array_two) { array.clone }
  let(:string) { ('a'..'z').to_a }
  let(:range_test) { Range.new(1, 13) }

  describe '1. #my_each Method' do
    it 'should have class of Enumerator' do
      expect(array.my_each.class).to eql(Enumerator)
    end
  end

  describe '2. #my_each Method' do
    it 'should not return nil' do
      expect(array.my_each).to_not be(nil)
    end
  end

  describe '3. #my_each Method' do
    it 'should not be an Array' do
      expect(string.my_each).to_not eql(Array)
    end
  end

  describe '4. #my_each Method' do
    let(:test_block) { proc { |n| n + 2 } }
    it 'should be the same as ruby built in method' do
      expect(array.my_each(&test_block)).to eql(array.each(&test_block))
    end
  end

  describe '1. #my_each_with_index Method' do
    it 'should return Enumerator' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '2. #my_each_with_index Method' do
    it 'should not return nil' do
      expect(array.my_each_with_index).to_not be(nil)
    end
  end

  describe '3. #my_each_with_index Method' do
    let(:test_block) { proc { |n| n + 2 } }
    it 'should not change the Array' do
      array.my_each_with_index(&test_block)
      expect(array).to eql(array_two)
    end
  end
end
