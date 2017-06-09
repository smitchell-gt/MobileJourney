//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Steven Mitchell on 6/7/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    private var variable: String?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var description: String = ""
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "±": Operation.unaryOperation({ -$0 }),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "=": Operation.equals,
        "C": Operation.clear
    ]
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
                
                if !resultIsPending {
                    description = buildStringFromDouble(accumulator!)
                }
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                    
                    if description.isEmpty {
                        description = symbol + "(" + buildStringFromDouble(accumulator!) + ")"
                    } else {
                        description = symbol + "(" + description + ")"
                    }
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    
                    if description.isEmpty {
                        description = buildStringFromDouble(accumulator!) + " " + symbol + " "
                    } else {
                        description += " " + symbol
                    }
                    
                    accumulator = nil
                }
                break
            case .equals:
                description += " " + buildStringFromDouble(accumulator!)
                performPendingBinaryOperation()
            case .clear:
                accumulator = 0
                description = ""
                pendingBinaryOperation = nil
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func setOperand(variable named: String) {
        variable = named
    }
    
    func evaluate(using variables: Dictionary<String,Double>? = nil) -> (result: Double?, isPending: Bool, description: String) {
        func performOperation(_ operation: Operation) -> (result: Double?, isPending: Bool, description: String) {
            return (result: nil, isPending: false, description: "")
        }
        
        if variables == nil || variable == nil { return (result: nil, isPending: false, description: "") }
        
        let result: (Double?, Bool, String)
        
        if let operation = operations[variable!] {
            result = performOperation(operation)
        }
        
        return (result: nil, isPending: false, description: "")
    }
    
    mutating func performPendingBinaryOperation() {
        if accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    func getOperationHistory() -> String {
        if description.isEmpty { return "" }
        
        if resultIsPending {
            return description + " ..."
        } else {
            return description + " ="
        }
    }
    
    func buildStringFromDouble(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
    var resultIsPending: Bool {
        get {
            return pendingBinaryOperation != nil
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
