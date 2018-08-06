//
//  ViewController.swift
//  AJCountryPickerDemo
//
//  Created by Aj Mehra on 26/07/16.
//  Copyright © 2016 TeamAj. All rights reserved.
//

import UIKit
import AJCountryPicker

class ViewController: UIViewController {

	// MARK:- IBOulets
	@IBOutlet private weak var label: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK:- IBActions
	@IBAction func selectCountry(_ sender: UIButton) -> Void {
        let countryPicker =
        countryPicker.showSearchBar = true
        countryPicker.customCountriesCodes = ["IN", "US"]
        countryPicker.showCallingCodes = true
        countryPicker.country = {
            print("Selected Country Name =====> ", $0.name)
            print("Selected Country ISO Code =====> ", $0.ISOCode)
            print("Selected Country Calling Code =====> ", $0.callingCode)
            
        }
        self.navigationController?.pushViewController(countryPicker, animated: true)
		//navigationController?.presentViewController(picker, animated: true, completion: nil)
	}
}


