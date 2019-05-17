//
//  SetupExerciseViewController.swift
//  Pila
//
//  Created by Dev2 on 08/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class SetupExerciseViewController: UIViewController {

    @IBOutlet weak var switchNegatives: UISwitch!
    @IBOutlet weak var lblMaxValue: UILabel!
    @IBOutlet weak var stepMaxValue: UIStepper!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var sliderSpeed: UISlider!
    
    deinit {
        debugPrint("Me muerooo setup exercise 🥶")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allowNegatives = UserDefaults.standard.bool(forKey: "allowNegatives")
        switchNegatives.isOn = allowNegatives
        
        let maxValue = UserDefaults.standard.double(forKey: "maxValue")
        lblMaxValue.text = "\(Int(maxValue))"
        stepMaxValue.value = maxValue
        
        let speedTime = UserDefaults.standard.float(forKey: "speedTime")
        let valueText = String(format: "%.2f", speedTime)
        lblSpeed.text = "Velocidad \(valueText)"
        sliderSpeed.value = speedTime
    }

    @IBAction func switchNegativeNumbersChanged(_ switchNegatives: UISwitch) {
        
        UserDefaults.standard.setValue(switchNegatives.isOn, forKey: "allowNegatives")
//
//        if switchNegatives.isOn {
//            debugPrint("negativos ON")
//        } else {
//            debugPrint("negativos OFF")
//        }
    }
    
    @IBAction func stepMaxValueChanged(_ stepper: UIStepper) {
        debugPrint(stepper.value)
        lblMaxValue.text = "\(Int(stepper.value))"
        UserDefaults.standard.setValue(stepper.value, forKey: "maxValue")
    }
    
    @IBAction func sliderSpeedChanged(_ sender: UISlider) {
        let valueText = String(format: "%.2f", sender.value)
        lblSpeed.text = "Velocidad \(valueText)"
        UserDefaults.standard.setValue(sender.value, forKey: "speedTime")

    }
}
