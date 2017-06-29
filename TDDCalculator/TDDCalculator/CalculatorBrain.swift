import Foundation

class CalculatorBrain {
    
    private enum Action {
        case operand(Double)
        case operation(String)
    }
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equals
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
        "÷": Operation.binary({ $0 / $1 }),
        "=": Operation.equals
    ]
    
    private var history: [Action] = []
    
    func setOperand(variable: String) {
        
    }
    
    func setOperand(double: Double) {
        history.append(Action.operand(double))
    }
    
    func performOperation(with symbol: String) {
        history.append(Action.operation(symbol))
    }
    
    func evaluate(using variableDictionary: Dictionary<String,Double>?) -> (result: Double?, isPending: Bool, description: String) {
        
        var operand: Double?
        var result: Double?
        var isPending: Bool = false
        var pendingOperation: ((Double,Double) -> Double)?
        var pendingOperand: Double?
        
        for action in history {
            switch action {
            case .operand(let value):
                operand = value
            case .operation(let symbol):
                if let operation = operations[symbol] {
                    switch operation {
                    case .constant(let value):
                        result = value
                        operand = value
                    case .unary(let function):
                        result = function(operand!)
                        operand = result
                    case .binary(let function):
                        pendingOperation = function
                        pendingOperand = operand
                        isPending = true
                    case .equals:
                        if isPending {
                            result = pendingOperation!(pendingOperand!, operand!)
                            operand = result
                            isPending = false
                        }
                    }
                }
            }
        }
        
        var description: String = ""
        
        for action in history {
            switch action {
            case .operand(let value):
                if !description.isEmpty {
                    description += " "
                }
                description += buildStringFromDouble(value)
            case .operation(let symbol):
                if let operation = operations[symbol] {
                    switch operation {
                    case .constant:
                        description += symbol
                    case .unary:
                        description = symbol + "(" + description + ")"
                    case .binary:
                        description += " " + symbol
                    case .equals:
                        break
                    }
                }
            }
        }
        
        if !isPending {
            description += " ="
        }
        
        return (result: result, isPending: isPending, description: description)
    }
    
    func clear() {
        
    }
    
    func popLastActionFromHistory() {
        
    }
    
    func buildStringFromDouble(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
}
