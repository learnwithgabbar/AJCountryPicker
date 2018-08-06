//
//  ViewController.swift
//  AjCountryPicker
//
//  Created by Ajay Mehra on 06/08/18.
//  Copyright © 2018 Aisha Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let countryPicker = AJCountryPicker()
        countryPicker.showSearchBar = true
        countryPicker.customCountriesCodes = ["IN", "US"]
        countryPicker.showCallingCodes = true
        countryPicker.country = {
            print("Selected Country Name =====> ", $0.name)
            print("Selected Country ISO Code =====> ", $0.ISOCode)
            print("Selected Country Calling Code =====> ", $0.callingCode)
            
        }
        self.navigationController?.pushViewController(countryPicker, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
