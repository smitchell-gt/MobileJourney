import Foundation

class CalculatorBrain {
    
    var operation: String?
    
    func setOperand(variable: String) {
        
    }
    
    func setOperand(double: Double) {
        
    }
    
    func performOperation(with symbol: String) {
        operation = symbol
    }
    
    func evaluate(using variableDictionary: Dictionary<String,Double>?) -> (result: Double?, isPending: Bool, description: String) {
        return (result: Double.pi, isPending: false, description: "")
    }
    
    func clear() {
        
    }
    
    func popLastActionFromHistory() {
        
    }
    
    func buildStringFromDouble(_ value: Double) -> String {
        return ""
    }
    
}
