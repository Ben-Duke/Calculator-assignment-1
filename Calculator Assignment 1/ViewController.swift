//
//  ViewController.swift
//  Calculator Assignment 1
//
//  Created by Ben Duke on 9/05/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var brain = CalculatorBrain()
    private var decimalUsed = false
    private var userIsInTheMiddleOfTyping = false
    
    @IBOutlet weak var display: UILabel!
    
    
    @IBAction func Clear(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        brain.clear()
        display.text = "0"
        
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        let TextCurrentlyInDisplay = display.text!
        
        if userIsInTheMiddleOfTyping{
            
            if digit == "." && decimalUsed == true{
                return
            }
            else if digit == "." && decimalUsed == false{
                decimalUsed = true
            }
            else{
                display.text = TextCurrentlyInDisplay + digit
            }
            display.text = TextCurrentlyInDisplay + digit
        }
        else{
            display!.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue : Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue
            )
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathaticalSymbol = sender.currentTitle{
            brain.performOperation(mathaticalSymbol)
        }
        if brain.result != nil{
            displayValue = brain.result!
        }
        
    }
}
