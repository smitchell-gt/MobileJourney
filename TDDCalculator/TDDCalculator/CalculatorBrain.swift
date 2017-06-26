import Foundation

class CalculatorBrain {
    
    var operationSymbol: String?
    var operand: Double = 0
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unary(sqrt),
        "±": Operation.unary({ -$0 }),
        "sin": Operation.unary(sin),
        "cos": Operation.unary(cos),
        "tan": Operation.unary(tan),
        "+": Operation.binary({ $0 + $1 }),
        "-": Operation.binary({ $0 - $1 }),
        "×": Operation.binary({ $0 * $1 }),
        "÷": Operation.binary({ $0 / $1 })
    ]
    
    func setOperand(variable: String) {
        
    }
    
    func setOperand(double: Double) {
        operand = double
    }
    
    func performOperation(with symbol: String) {
        operationSymbol = symbol
    }
    
    func evaluate(using variableDictionary: Dictionary<String,Double>?) -> (result: Double?, isPending: Bool, description: String) {
        
        var result: Double?
        var isPending: Bool = false
        
        if let operation = operations[operationSymbol!] {
            switch operation {
            case .constant(let value):
                result = value
            case .unary(let function):
                result = function(operand)
            case .binary:
                isPending = true
            }
        }
        
        return (result: result, isPending: isPending, description: "")
    }
    
    func clear() {
        
    }
    
    func popLastActionFromHistory() {
        
    }
    
    func buildStringFromDouble(_ value: Double) -> String {
        return ""
    }
    
}
