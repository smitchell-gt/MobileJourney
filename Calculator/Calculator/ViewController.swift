//
//  ViewController.swift
//  Calculator
//
//  Created by Steven Mitchell on 6/6/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    private var calculatorBrain: CalculatorBrain = CalculatorBrain()
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = buildStringFromDouble(newValue)
        }
    }
    
    func buildStringFromDouble(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
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
            display.text = textCurrentlyInDisplay + "."
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            calculatorBrain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculatorBrain.performOperation(mathematicalSymbol)
        }
        
        if let result = calculatorBrain.result {
            displayValue = result
        }
    }
}
