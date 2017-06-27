@testable import TDDCalculator
import Quick
import Nimble

class CalculatorBrainSpec: QuickSpec {
    override func spec() {
        describe("Calculator Brain") {
            context("evaluate constants") {
                it("should return value of pi when operation is π") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.performOperation(with: "π")
                    let expected = (result: Double.pi, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                }
                
                it("should return value of pi when operation is π") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.performOperation(with: "e")
                    let expected = (result: M_E, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                }
            }
            
            context("evaluate unary operations") {
                it("should return value of 2 when operation is √4") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 4)
                    calculatorBrain.performOperation(with: "√")
                    let expected = (result: 2.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                }
                
                it("should return value of -4 when operation is ±4") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 4)
                    calculatorBrain.performOperation(with: "±")
                    let expected = (result: -4.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                }
                
                it("should return value of 1 when operation is sin(π/2)") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: Double.pi/2)
                    calculatorBrain.performOperation(with: "sin")
                    let expected = (result: 1.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                }
                
                it("should return value of -1 when operation is cos(π)") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: Double.pi)
                    calculatorBrain.performOperation(with: "cos")
                    let expected = (result: -1.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                }
                
                it("should return value of 0 when operation is tan(0)") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 0)
                    calculatorBrain.performOperation(with: "tan")
                    let expected = (result: 0.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                }
            }
            
            context("evaluate binary operations") {
                it("should return value of nil and isPending true when operation is 2 +") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 2)
                    calculatorBrain.performOperation(with: "+")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(beNil())
                    expect(actual.isPending).to(beTrue())
                }
                
                it("should return value of nil and isPending true when operation is 3 -") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "-")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(beNil())
                    expect(actual.isPending).to(beTrue())
                }
                
                it("should return value of nil and isPending true when operation is 4 *") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 4)
                    calculatorBrain.performOperation(with: "×")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(beNil())
                    expect(actual.isPending).to(beTrue())
                }
                
                it("should return value of nil and isPending true when operation is 5 /") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 5)
                    calculatorBrain.performOperation(with: "÷")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(beNil())
                    expect(actual.isPending).to(beTrue())
                }
            }
            
            context("evaluate pending operations") {
                it("should return value of 5 and isPending of false when operation is 2 + 3 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 2)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: 5.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
            }
        }
    }
}
