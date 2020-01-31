class Calculator
    def add(a , b)
        a+b
    end
    def fact(n)
        if n == 1
            return 1
        else 
            n * fact(n-1)
        end
    end
end
  
describe Calculator do
    describe "#add" do
      it "adds two numbers" do
        calculator = Calculator.new
  
        expect(calculator.add(1, 1)).to eq(2)
      end
    end

    describe "#fact" do
        it "calculates factorial of a number" do
            calc = Calculator.new
            expect(calc.fact(4)).to eq(24)
        end
    end
  end

