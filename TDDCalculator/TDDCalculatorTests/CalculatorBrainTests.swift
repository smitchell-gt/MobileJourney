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
        }
    }
}
