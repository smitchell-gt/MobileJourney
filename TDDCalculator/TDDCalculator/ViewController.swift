import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var memoryDisplay: UILabel!
    @IBOutlet weak var historyDisplay: UILabel!

    var userIsInTheMiddleOfTyping = false
    private var calculatorBrain: CalculatorBrain = CalculatorBrain()
    private var variables: Dictionary<String,Double>?
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = calculatorBrain.buildStringFromDouble(newValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func addDecimal(_ sender: UIButton) {
        let textCurrentlyInDisplay = display.text!
        
        if !textCurrentlyInDisplay.contains(".") {
            if !userIsInTheMiddleOfTyping {
                display.text = "0."
                userIsInTheMiddleOfTyping = true
            } else {
                display.text = textCurrentlyInDisplay + "."
            }
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        calculatorBrain.clear()
        displayValue = 0
        variables = nil
        userIsInTheMiddleOfTyping = false
        updateHistory(description: "", resultIsPending: false)
        updateMemoryLabel(value: 0)
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            calculatorBrain.setOperand(double: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculatorBrain.performOperation(with: mathematicalSymbol)
        }
        
        let results: (result: Double?, isPending: Bool, description: String) = calculatorBrain.evaluate(using: variables)
        
        if results.result != nil {
            displayValue = results.result!
        }
        
        updateHistory(description: results.description, resultIsPending: results.isPending)
    }
    
    @IBAction func setMemory(_ sender: UIButton) {
        variables = [
            "M": displayValue
        ]
        
        updateMemoryLabel(value: displayValue)
        
        let results: (result: Double?, isPending: Bool, description: String) = calculatorBrain.evaluate(using: variables)
        
        if results.result != nil {
            displayValue = results.result!
        }
        
        updateHistory(description: results.description, resultIsPending: results.isPending)
    }
    
    @IBAction func useMemory(_ sender: UIButton) {
        calculatorBrain.setOperand(variable: "M")
    }
    
    @IBAction func undo(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            if !(display.text?.isEmpty)! {
                let textCurrentlyInDisplay = display.text!
                let lastCharacterIndex = textCurrentlyInDisplay.index(before: textCurrentlyInDisplay.endIndex)
                display.text = textCurrentlyInDisplay.substring(to: lastCharacterIndex)
            }
            
            if (display.text?.isEmpty)! {
                displayValue = 0
                userIsInTheMiddleOfTyping = false
            }
        }
        if !userIsInTheMiddleOfTyping {
            _ = calculatorBrain.popLastActionFromHistory()
            
            let results = calculatorBrain.evaluate(using: variables)
            
            if results.result != nil {
                displayValue = results.result!
            } else {
                displayValue = 0
            }
            
            updateHistory(description: results.description, resultIsPending: results.isPending)
        }
    }
    
    func updateHistory(description: String, resultIsPending: Bool) {
        if description.isEmpty {
            historyDisplay.text = description
        } else if resultIsPending {
            historyDisplay.text = description + " ..."
        } else {
            historyDisplay.text = description + " ="
        }
    }
    
    func updateMemoryLabel(value: Double) {
        memoryDisplay.text = "M=" + calculatorBrain.buildStringFromDouble(value)
    }
}

