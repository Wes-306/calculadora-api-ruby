# spec/models/calculator_spec.rb
require 'rails_helper'

RSpec.describe Calculator do
  subject(:calculator) { described_class.new }

  describe '#add' do
    it 'soma dois números corretamente' do
      expect(calculator.add(2, 3)).to eq(5)
    end
  end

  describe '#subtract' do
    it 'subtrai dois números corretamente' do
      expect(calculator.subtract(5, 3)).to eq(2)
    end
  end

  describe '#multiply' do
    it 'multiplica dois números corretamente' do
      expect(calculator.multiply(4, 3)).to eq(12)
    end
  end

  describe '#divide' do
    it 'divide dois números corretamente' do
      # Esperamos um float (5.0) para garantir que não estamos truncando decimais
      expect(calculator.divide(10, 2)).to eq(5.0) 
    end

    it 'levanta um erro ao dividir por zero' do
      expect { calculator.divide(10, 0) }.to raise_error(ZeroDivisionError)
    end
  end
end