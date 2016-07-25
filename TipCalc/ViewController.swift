//
//  ViewController.swift
//  TipCalc
//
//  Created by ruiyang_wu on 7/25/16.
//  Copyright © 2016 ruiyang_wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var maxValue: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onBillChanged(sender: AnyObject) {
        // Cache value entered
        let bill = Double(billField.text!) ?? 0
        let currentTime = NSDate().timeIntervalSince1970
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(bill, forKey: "cached_value")
        defaults.setDouble(currentTime, forKey: "cached_time")
        defaults.synchronize()
        print("saved: ", bill)
        
        calculateTip(self)
    }
    
    func convertToCurrency(input: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(input)!
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let selectedPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let tip = bill * selectedPercentage
        let total = bill + tip
        
        //tipLabel.text = String(format: "$%.2f", tip)
        tipLabel.text = self.convertToCurrency(tip)
        //totalLabel.text = String(format: "$%.2f", total)
        totalLabel.text = self.convertToCurrency(total)
        
        if (total > Double(maxValue)) {
            totalLabel.textColor = UIColor.redColor()
        }
        else {
            totalLabel.textColor = UIColor.blackColor()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        // Load default percentage preference
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("default_percentage")
        tipControl.selectedSegmentIndex = intValue
        
        // Load cached value if not timeout
        let cachedValue = defaults.integerForKey("cached_value")
        let cachedTime = defaults.doubleForKey("cached_time")
        let currentTime = NSDate().timeIntervalSince1970
        let timeDiff = (currentTime - cachedTime) / 60
        print("Time diff: ", timeDiff)
        if (timeDiff < 10) {
            print("using cached value: ", cachedValue)
            billField.text = String(cachedValue)
        }
        
        // Load maximum value to spend
        maxValue = defaults.integerForKey("max_value") ?? 1000
        
        // Calculate Tip And Display
        calculateTip(self)
        
        // Animation -- fade in
        UIView.animateWithDuration(2.8, animations: {
            print("fade in")
            self.tipControl.alpha = 1
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        // Animation -- fade out
        UIView.animateWithDuration(1.8, animations: {
            print("fade out")
            self.tipControl.alpha = 0
        })
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
}

