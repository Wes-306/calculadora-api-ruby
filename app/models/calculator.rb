# app/models/calculator.rb

class Calculator
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  def divide(a, b)

    raise ZeroDivisionError, "Não é possível dividir por zero" if b.zero?

    # Convertendo o denominador para float (.to_f) garantimos a precisão decimal.
    # Em Ruby, dividir dois inteiros (ex: 5 / 2) resulta em um inteiro (2).
    # Ao fazer 5 / 2.0, o Ruby nos retorna o esperado (2.5).
    a / b.to_f
  end
end