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
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var description: String = ""
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "C": Operation.constant(0),
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
        "=": Operation.equals
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
                
                if description.isEmpty {
                    description = buildStringFromDouble(value)
                } else {
                    description += buildStringFromDouble(value)
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
                        description += symbol
                    }
                    
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func performPendingBinaryOperation() {
        if accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
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
        set {
            resultIsPending = newValue
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
