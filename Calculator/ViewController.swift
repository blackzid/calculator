//
//  ViewController.swift
//  Calculator
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import UIKit
import CalculatorCore

class ViewController: UIViewController {

    var core: Core<Float>!
    func resetCore() {
        self.core = Core()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetCore()
    }
    
    var hasOperator: Bool = false
    
    @IBOutlet weak var displayLabel: DisplayLabel!

    @IBAction func numericButtonClicked(sender: UIButton) {
        if sender.tag >= 1000 && sender.tag < 1010 {
            self.displayLabel.append(sender.tag - 1000)
        } else if sender.tag == 1010 {
            self.displayLabel.append(0)
            self.displayLabel.append(0)
        }
        hasOperator = false
    }

    @IBAction func negativeButtonClicked(sender: UIButton) {
        self.displayLabel.changeSign()
    }

    
    
    @IBAction func operatorButtonClicked(sender: UIButton) {
        if hasOperator {
            self.core.popPreviousStep()
        }
        else {
            try! self.core.addStep(self.displayLabel.floatValue)
        }
        switch (sender.titleForState(.Normal)!) {
        case "+":
            try! self.core.addStep(+)
        case "-":
            try! self.core.addStep(-)
        case "×":
            try! self.core.addStep(*)
        case "÷":
            try! self.core.addStep(/)
        default:
            break
        }
        hasOperator = true
        self.displayLabel.clear()
    }
    
    @IBAction func dotButtonClicked(sender: UIButton) {
        self.displayLabel.appendDot()
    }
    
    var highlightButton: UIButton?
    
    @IBAction func highlightButton(sender: UIButton) {
        clearHighlightButton()
        highlightButton = sender
        highlightButton!.layer.borderColor = UIColor.blackColor().CGColor
        highlightButton!.layer.borderWidth = 2.0
    }
    
    func clearHighlightButton() {
        if highlightButton != nil {
            highlightButton!.layer.borderWidth = 0
        }
    }
    
    @IBAction func percentageButtonClicked(sender: UIButton) {
        self.displayLabel.floatValue = self.displayLabel.floatValue / 100.0
    }
    
    @IBAction func calculateButtonClicked(sender: UIButton) {
        clearHighlightButton()
        hasOperator = false
        try! self.core.addStep(self.displayLabel.floatValue)
        self.displayLabel.floatValue = try! self.core.calculate()
        self.resetCore()
    }

    @IBAction func resetButtonClicked(sender: UIButton) {
        clearHighlightButton()
        self.resetCore()
        self.displayLabel.clear()
    }
}

