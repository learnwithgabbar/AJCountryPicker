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
	@IBAction func selectCountryButtonTapped(sender: UIButton) -> Void {
		let picker = AJCountryPicker { (country, code) -> () in
			self.label.text = "Selected Country " + country
		}

		// Optional: To pick from custom countries list
		picker.customCountriesCode = ["EG", "US", "AF", "AQ", "AX", "IN"]

		// delegate
		picker.delegate = self

		// Display calling codes
		picker.showCallingCodes = true

		// or closure
		picker.countryWithCode = { (country, code) -> () in
			// picker.navigationController?.popToRootViewControllerAnimated(true)
		}
		navigationController?.pushViewController(picker, animated: true)
		//navigationController?.presentViewController(picker, animated: true, completion: nil)
	}
}

extension ViewController: AJCountryPickerDelegate {
	func ajCountryPicker(picker: AJCountryPicker, didSelectCountryWithName name: String, code: String) {
		label.text = "Selected Country: \(name)"
	}
}
