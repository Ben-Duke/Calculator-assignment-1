//
//  CalculatorBrain.swift
//  Calculator Assignment 1
//
//  Created by Ben Duke on 9/05/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double{
    return -operand
}

struct CalculatorBrain {
    
    private var accumluator : Double?
    
    
    var resultIsPending = false
    
    var description : String?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double ) -> Double)
        case equals
    }
    
    func pendingResult() -> Bool{
        return resultIsPending
    }
    
    mutating func clear() -> Void{
        accumluator = 0.0
    }
    
    private var operations : Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "💱"  : Operation.unaryOperation(changeSign),
        "✖️" : Operation.binaryOperation({$0 * $1}),
        "➗" : Operation.binaryOperation({$0 / $1}),
        "➕" : Operation.binaryOperation({$0 + $1}),
        "➖" : Operation.binaryOperation({$0 - $1}),
        "=" : Operation.equals
    ]
    
    private struct PendingBinaryOperation{
        let perform : (Double, Double) -> Double
        let firstOperand : Double
    }
    
    private var pending: PendingBinaryOperation?
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol]{
            switch operation{
            case .constant(let Value):
                accumluator = Value
            
            case .unaryOperation (let function):
                if accumluator != nil{
                    accumluator = function(accumluator!)
                    resultIsPending = true
                }
                
            case .binaryOperation(let function):
                performPendingBinaryOperation()
                if accumluator != nil{
                
                pending = PendingBinaryOperation(perform: function, firstOperand: accumluator!)
                
                accumluator = nil
                resultIsPending = true
                }
                
            case .equals:
                performPendingBinaryOperation()
                resultIsPending = false
            }
        
        }
    }
    
    
    private mutating func performPendingBinaryOperation(){
        if pending !=  nil{
           accumluator = pending!.perform(pending!.firstOperand, accumluator!)
            pending = nil

        }
            }
    
    mutating func setOperand(_ operand : Double){
        accumluator = operand
    }
    
    var result : Double?{
        get{
            return accumluator
        }
    }
    
    
    
}
