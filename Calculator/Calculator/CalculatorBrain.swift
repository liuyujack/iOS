//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Yu Liu on 16/09/2015.
//  Copyright (c) 2015 Yu Liu. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    enum Op{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    var opStack = [Op]()
    
//    var knownOps = Dictionary<String,Op>()
    var knownOps = [String:Op]()
    
    init() {
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) {
        
    }
}