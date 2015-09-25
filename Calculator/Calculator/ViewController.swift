//
//  ViewController.swift
//  Calculator
//
//  Created by Yu Liu on 15/09/2015.
//  Copyright (c) 2015 Yu Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleOfTypingANumber = false
    var userHasUsedPoint = false
    
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleOfTypingANumber{
            if digit == "."
            {
                if !userHasUsedPoint
                {
                    display.text = display.text! + digit
                }
                userHasUsedPoint = true
            } else if digit != "π"{
                display.text = display.text! + digit
            }
        } else {
            if digit == "."
            {
                display.text = "0\(digit)"
                userHasUsedPoint = true
                userIsInMiddleOfTypingANumber = true
            } else if digit != "π"{
                display.text = digit
                userIsInMiddleOfTypingANumber = true
            } else {
                display.text = "π"
                enter()
                display.text = "π"
            }
            
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func performOperationOne(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInMiddleOfTypingANumber = false
        userHasUsedPoint = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        
    }
    
    var displayValue: Double {
        get {
            if display.text! == "π" {
                return M_PI
            }
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue;
        }
        set {
            display.text! = "\(newValue)"
            userIsInMiddleOfTypingANumber = false
        }
    }
}

