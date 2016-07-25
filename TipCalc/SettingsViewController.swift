//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by ruiyang_wu on 7/25/16.
//  Copyright © 2016 ruiyang_wu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var selectedDefaultPercentage: UISegmentedControl!
    
    @IBOutlet weak var maxValueField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultPercentage = defaults.integerForKey("default_percentage") ?? 0
        selectedDefaultPercentage.selectedSegmentIndex = defaultPercentage
        let maxValue = defaults.integerForKey("max_value") ?? 1000
        maxValueField.text = String(maxValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectionChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let selectionIndex = selectedDefaultPercentage.selectedSegmentIndex
        defaults.setInteger(selectionIndex, forKey: "default_percentage")
        defaults.synchronize()
    }

    @IBAction func maxValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let maxValue = Int(maxValueField.text!) ?? 0
        defaults.setInteger(maxValue, forKey: "max_value")
        defaults.synchronize()
        print("Set max value: ", maxValue)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
