import Foundation

class CalculatorBrain {
    
    func setOperand(variable: String) {
        
    }
    
    func setOperand(double: Double) {
        
    }
    
    func performOperation(with symbol: String) {
        
    }
    
    func evaluate(using variableDictionary: Dictionary<String,Double>?) -> (result: Double?, isPending: Bool, description: String) {
        return (result: nil, isPending: false, description: "")
    }
    
    func clear() {
        
    }
    
    func popLastActionFromHistory() {
        
    }
    
    func buildStringFromDouble(_ value: Double) -> String {
        return ""
    }
}
