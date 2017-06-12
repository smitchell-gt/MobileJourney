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
    
//    mutating func performOperation(_ symbol: String) {
//        if let operation = operations[symbol] {
//            switch operation {
//            case .constant(let value):
//                accumulator = value
//                
//                if !resultIsPending {
//                    description = buildStringFromDouble(accumulator!)
//                }
//            case .unaryOperation(let function):
//                if accumulator != nil {
//                    accumulator = function(accumulator!)
//                    
//                    if description.isEmpty {
//                        description = symbol + "(" + buildStringFromDouble(accumulator!) + ")"
//                    } else {
//                        description = symbol + "(" + description + ")"
//                    }
//                }
//            case .binaryOperation(let function):
//                if accumulator != nil {
//                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
//                    
//                    if description.isEmpty {
//                        description = buildStringFromDouble(accumulator!) + " " + symbol + " "
//                    } else {
//                        description += " " + symbol
//                    }
//                    
//                    accumulator = nil
//                }
//                break
//            case .equals:
//                description += " " + buildStringFromDouble(accumulator!)
//                performPendingBinaryOperation()
//            case .clear:
//                accumulator = 0
//                description = ""
//                pendingBinaryOperation = nil
//            }
//        }
//    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func setOperand(double value: Double) {
        history.append(.value(String(value)))
    }
    
    mutating func setOperand(variable named: String) {
        history.append(.value(named))
    }
    
    mutating func performOperation(_ symbol: String) {
        history.append(.operation(symbol))
    }
    
    func evaluate(using variables: Dictionary<String,Double>? = nil) -> (result: Double?, isPending: Bool, description: String) {
        var accumulator: Double?
        var pendingBinaryOperation: PendingBinaryOperation?
        var description = ""
        
        var resultIsPending: Bool {
            get {
                return pendingBinaryOperation != nil
            }
        }
        
        func convertToDouble(_ action: String) -> Double {
            if let double = Double(action) {
                return double
            }
            
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
                    }
                    
                case .equals:
                    description += " " + buildStringFromDouble(accumulator!)
                    performPendingBinaryOperation()
                }
            }
        }
        
        for action in history {
            switch action {
            case .value(let value):
                accumulator = convertToDouble(value)
            case .operation(let symbol):
                performOperation(symbol)
            }
        }
        
        return (result: accumulator, isPending: resultIsPending, description: description)
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
