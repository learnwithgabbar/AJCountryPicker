//
//  ViewController.swift
//  AjCountryPicker
//
//  Created by Ajay Mehra on 06/08/18.
//  Copyright © 2018 Aisha Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var displayLabel: UILabel!

    @IBAction private func selectCountry(_ sender: UIButton) {
        let countryPicker = AJCountryPicker()
        countryPicker.showSearchBar = true

        countryPicker.showCallingCodes = true
        countryPicker.country = {
            self.displayLabel.text = "You have selected " + $0.name + "with ISO Code" + $0.ISOCode + "Your Calling code is " + $0.callingCode
        }
        navigationController?.pushViewController(countryPicker, animated: true)
    }

    @IBAction private func selectCountryWithCustomCodes(_ sender: UIButton) {
        let countryPicker = AJCountryPicker()
        countryPicker.showSearchBar = true
        countryPicker.customCountriesCodes = ["IN", "US"]
        countryPicker.showCallingCodes = true
        countryPicker.country = {
            self.displayLabel.text = "You have selected " + $0.name + "with ISO Code" + $0.ISOCode + "Your Calling code is " + $0.callingCode
        }
        navigationController?.pushViewController(countryPicker, animated: true)
    }

 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
