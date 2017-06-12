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
    @IBOutlet weak var historyDisplay: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    private var calculatorBrain: CalculatorBrain = CalculatorBrain()
    
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
        updateHistory(description: "", resultIsPending: false)
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            calculatorBrain.setOperand(double: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculatorBrain.performOperation(mathematicalSymbol)
        }
        
        let results: (result: Double?, isPending: Bool, description: String) = calculatorBrain.evaluate()
        
        if results.result != nil {
            displayValue = results.result!
        }
        
        updateHistory(description: results.description, resultIsPending: results.isPending)
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
}
