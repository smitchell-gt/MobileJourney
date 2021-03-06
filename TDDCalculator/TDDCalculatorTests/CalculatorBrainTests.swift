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
                
                it("should return value of -1 and isPending of false when operation is 2 - 3 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 2)
                    calculatorBrain.performOperation(with: "-")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: -1.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
                
                it("should return value of 6 and isPending of false when operation is 2 × 3 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 2)
                    calculatorBrain.performOperation(with: "×")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: 6.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
                
                it("should return value of 4 and isPending of false when operation is 12 ÷ 3 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 12)
                    calculatorBrain.performOperation(with: "÷")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: 4.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
            }
            
            context("evaluate binary operations with constants") {
                it("should return value of 4.14 when operation is 1 + π =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 1)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.performOperation(with: "π")
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: 1 + Double.pi, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
                
                it("should return value of 4.14 when operation is π + 1 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.performOperation(with: "π")
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 1)
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: 1 + Double.pi, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
                
                it("should return value of 3.14 when operation is 1 + 3 = π") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 1)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "π")
                    
                    let expected = (result: Double.pi, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
            }
            
            context("evaluate unary operations within binary operations") {
                it("should return value of 4 when operation is 1 + 9 √ =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 1)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "√")
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: 4.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
                
                it("should return value of 4 when operation is 9 √ + 1 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "√")
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 1)
                    calculatorBrain.performOperation(with: "=")
                    
                    let expected = (result: 4.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
                
                it("should return value of 2 when operation is 3 + 1 = √") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 1)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "√")
                    
                    let expected = (result: 2.0, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expected.result))
                    expect(actual.isPending).to(equal(expected.isPending))
                }
            }
            
            context("build description") {
                it("should return description of 'π' when operation is π") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.performOperation(with: "π")
                    let expectedDescription = "π"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of 'cos(3)' when operation is 3 cos") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "cos")
                    let expectedDescription = "cos(3)"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '7 +' when operation is 7 +") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    let expectedDescription = "7 +"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '7 + 9' when operation is 7 + 9") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "=")
                    let expectedDescription = "7 + 9"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '√(7 + 9)' when operation is 7 + 9 = √") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "√")
                    let expectedDescription = "√(7 + 9)"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '7 + √(9)' when operation is 7 + 9 √ =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "√")
                    calculatorBrain.performOperation(with: "=")
                    let expectedDescription = "7 + √(9)"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '√(7 + 9) + 2' when operation is 7 + 9 = √ + 2 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "√")
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 2)
                    calculatorBrain.performOperation(with: "=")
                    let expectedDescription = "√(7 + 9) + 2"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '7 + 9 + 6 + 3' when operation is 7 + 9 = + 6 = + 3 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 6)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    let expectedDescription = "7 + 9 + 6 + 3"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '6 + 3' when operation is 7 + 9 = √ 6 + 3 =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "√")
                    calculatorBrain.setOperand(double: 6)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    let expectedDescription = "6 + 3"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
                
                it("should return description of '4 × π' when operation is 4 × π =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 4)
                    calculatorBrain.performOperation(with: "×")
                    calculatorBrain.performOperation(with: "π")
                    calculatorBrain.performOperation(with: "=")
                    let expectedDescription = "4 × π"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
            }
            
            context("build clean string from double") {
                it("should truncate .0 when given a whole number") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    let expectedString = "3"
                    
                    // when
                    let actualString = calculatorBrain.buildStringFromDouble(3.0)
                    
                    // then
                    expect(actualString).to(equal(expectedString))
                }
                
                it("should not truncate digits from decimal numbers") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    let expectedString = "3.14"
                    
                    // when
                    let actualString = calculatorBrain.buildStringFromDouble(3.14)
                    
                    // then
                    expect(actualString).to(equal(expectedString))
                }
            }
            
            context("clear") {
                it("should clear history") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.performOperation(with: "√")
                    calculatorBrain.setOperand(double: 6)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 3)
                    calculatorBrain.performOperation(with: "=")
                    calculatorBrain.clear()
                    
                    let expected: (result: Double?, isPending: Bool, description: String) = (result: nil, isPending: false, description: "")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(beNil())
                    expect(actual.isPending).to(equal(expected.isPending))
                    expect(actual.description).to(equal(expected.description))
                }
            }
            
            context("popLastActionFromHistory") {
                it("should set result to nil and isPending to true and description to '7 + ' when = is popped") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(double: 9)
                    calculatorBrain.performOperation(with: "=")
                    
                    calculatorBrain.popLastActionFromHistory()
                    
                    let expected: (result: Double?, isPending: Bool, description: String) = (result: nil, isPending: true, description: "7 + ")
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(beNil())
                    expect(actual.isPending).to(equal(expected.isPending))
                    expect(actual.description).to(equal(expected.description))
                }
            }
            
            context("evaluate using variable dictionary") {
                it("should return 7 when operation is '7 + x' and no dictionary is provided") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(variable: "x")
                    calculatorBrain.performOperation(with: "=")
                    
                    let expectedResult: Double = 7
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: nil)
                    
                    // then
                    expect(actual.result).to(equal(expectedResult))
                }
                
                it("should return 7 when operation is '7 + x' and a dictionary that doesn't contain x is provided") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(variable: "x")
                    calculatorBrain.performOperation(with: "=")
                    
                    let expectedResult: Double = 7
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: Dictionary<String,Double>())
                    
                    // then
                    expect(actual.result).to(equal(expectedResult))
                }
                
                it("should return 10 when operation is '7 + x' and a dictionary that contains x = 3") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(variable: "x")
                    calculatorBrain.performOperation(with: "=")
                    
                    let expectedResult: Double = 10
                    
                    var variables = Dictionary<String,Double>()
                    variables["x"] = 3
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: variables)
                    
                    // then
                    expect(actual.result).to(equal(expectedResult))
                }
                
                it("should return description of '7 + x' when operation is 7 + x =") {
                    // if
                    let calculatorBrain = CalculatorBrain()
                    calculatorBrain.setOperand(double: 7)
                    calculatorBrain.performOperation(with: "+")
                    calculatorBrain.setOperand(variable: "x")
                    calculatorBrain.performOperation(with: "=")
                    
                    var variables = Dictionary<String,Double>()
                    variables["x"] = 3
                    
                    let expectedDescription = "7 + x"
                    
                    // when
                    let actual = calculatorBrain.evaluate(using: variables)
                    
                    // then
                    expect(actual.description).to(equal(expectedDescription))
                }
            }
        }
    }
}
