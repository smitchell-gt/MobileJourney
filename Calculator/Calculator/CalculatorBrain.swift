//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Steven Mitchell on 6/7/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var history: [Action] = []
    
    private enum Action {
        case value(String)
        case operation(String)
        
        func get() -> String {
            switch self {
            case .value(let value):
                return value
            case .operation(let operation):
                return operation
            }
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
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
        "=": Operation.equals
    ]
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(double value: Double) {
        history.append(.value(String(value)))
    }
    
    mutating func setOperand(variable named: String) {
        history.append(.value(named))
    }
    
    mutating func performOperation(with symbol: String) {
        history.append(.operation(symbol))
    }
    
    func evaluate(using variables: Dictionary<String,Double>? = nil) -> (result: Double?, isPending: Bool, description: String) {
        var accumulator: Double?
        var pendingBinaryOperation: PendingBinaryOperation?
        var description = ""
        var constantOperand: String?
        var hasUnaryOperand: Bool = false
        var operand: String?
        
        var resultIsPending: Bool {
            get {
                return pendingBinaryOperation != nil
            }
        }
        
        func convertToDouble(_ action: String) -> Double {
            if let double = Double(action) {
                operand = buildStringFromDouble(double)
                return double
            }
            
            operand = action
            
            if variables == nil {
                return 0.0
            }
            
            if let double = variables![action] {
                return double
            }
            
            return 0.0
        }
        
        func performPendingBinaryOperation() {
            if accumulator != nil {
                accumulator = pendingBinaryOperation?.perform(with: accumulator!)
                pendingBinaryOperation = nil
            }
        }
        
        func performOperation(_ symbol: String) {
            if let operation = operations[symbol] {
                switch operation {
                case .constant(let value):
                    accumulator = value
                    
                    if !resultIsPending {
                        description = symbol
                    } else {
                        constantOperand = symbol
                    }
                    
                case .unaryOperation(let function):
                    if accumulator != nil {
                        if description.isEmpty {
                            description = symbol + "(" + operand! + ")"
                        } else if resultIsPending {
                            description += " " + symbol + "(" + operand! + ")"
                            hasUnaryOperand = true
                        } else {
                            description = symbol + "(" + description + ")"
                        }
                        
                        accumulator = function(accumulator!)
                    }
                    
                case .binaryOperation(let function):
                    if accumulator != nil {
                        pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                        
                        if description.isEmpty {
                            description = operand! + " " + symbol
                        } else {
                            description += " " + symbol
                        }
                    }
                    
                case .equals:
                    if accumulator != nil {
                        if constantOperand != nil {
                            description += " " + constantOperand!
                        } else if !hasUnaryOperand {
                            description += " " + operand!
                        }
                        performPendingBinaryOperation()
                        hasUnaryOperand = false
                    }
                }
            }
        }
        
        for action in history {
            switch action {
            case .value(let value):
                if accumulator != convertToDouble(value) && !resultIsPending {
                    description = ""
                }
                accumulator = convertToDouble(value)
            case .operation(let symbol):
                performOperation(symbol)
            }
        }
        
        return (result: accumulator, isPending: resultIsPending, description: description)
    }
    
    mutating func clear() {
        history = []
    }
    
    mutating func popLastActionFromHistory() {
        if !history.isEmpty {
            _ = history.popLast()!
        }
    }
    
    func buildStringFromDouble(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
    @available(*, deprecated)
    private var accumulator: Double?
    
    @available(*, deprecated)
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    @available(*, deprecated)
    private var description: String = ""
    
    @available(*, deprecated)
    mutating func performPendingBinaryOperation() {
        if accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    @available(*, deprecated)
    var resultIsPending: Bool {
        get {
            return pendingBinaryOperation != nil
        }
    }
    
    @available(*, deprecated)
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    @available(*, deprecated)
    func getOperationHistory() -> String {
        if description.isEmpty { return "" }
        
        if resultIsPending {
            return description + " ..."
        } else {
            return description + " ="
        }
    }
    
    @available(*, deprecated)
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    @available(*, deprecated)
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
            }
        }
    }
}
