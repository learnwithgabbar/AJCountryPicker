//
//  AJCountryPicker.swift
//  AJCountryPicker
//
//  Created by Aj Mehra on 25/07/16.
//  Copyright © 2016 TeamAj. All rights reserved.
//

import UIKit

@objc public protocol AJCountryPickerDelegate: class {
	func ajCountryPicker(picker: AJCountryPicker, didSelectCountryWithName name: String, code: String)
	optional func ajCountryPicker(picker: AJCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
	optional func ajCountryPicker(picker: AJCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String, flag: UIImage?)

}

public class AJCountryPicker: UITableViewController {

	// MARK:- Constants

	let countryCellIdentifier = "AJCountryCell"

	// MARK:- Variables
	// MARK: ..... Public Variables
	public var customCountriesCode: [String]?
	public var showCountryFlags = true
	public var showSection = false
	public var showSearchBar = true
	public weak var delegate: AJCountryPickerDelegate?
	public var countryWithCode: ((String, String) -> ())?
	public var countryWithCodeAndCallingCode: ((String, String, String) -> ())?
	public var countryWithFlagAndCallingCode: ((String, String, String, UIImage?) -> ())?
	public var showCallingCodes = false

	// MARK: ..... Private Variables
	private var searchController: UISearchController!
	private var filteredList = [AJCountry]()

	private var allCountries: [AJCountry] {
		let locale = NSLocale.currentLocale()
		var unsourtedCountries = [AJCountry]()
		let countriesCodes = customCountriesCode == nil ? NSLocale.ISOCountryCodes() : customCountriesCode!

		for countryCode in countriesCodes {
			let displayName = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode)
			let countryData = AJCallingCodes.filter { $0["code"] == countryCode }
			let country: AJCountry
			if countryData.count > 0, let dialCode = countryData[0]["dialCode"] {
				country = AJCountry(name: displayName!, code: countryCode, dialCode: dialCode)
			} else {
				country = AJCountry(name: displayName!, code: countryCode)
			}
			unsourtedCountries.append(country)
		}
		return unsourtedCountries
	}

	private var sections: [Section] {
		let countries: [AJCountry] = allCountries.map { country in
			let country = AJCountry(name: country.name, code: country.code, dialCode: country.dialCode)
			country.section = collation.sectionForObject(country, collationStringSelector: Selector("name"))
			return country
		}

		// create empty sections
		var sections = [Section]()
		for _ in 0..<self.collation.sectionIndexTitles.count {
			sections.append(Section())
		}

		// put each country in a section
		for country in countries {
			sections[country.section!].addCountry(country)
		}

		// sort each section
		for section in sections {
			var s = section
			s.countries = collation.sortedArrayFromArray(section.countries, collationStringSelector: Selector("name")) as! [AJCountry]
		}

		return sections
	}

	private let collation = UILocalizedIndexedCollation.currentCollation()
	as UILocalizedIndexedCollation

	// MARK:- Initalizer
	convenience public init(completionHandler: ((String, String) -> ())) {
		self.init()
		self.countryWithCode = completionHandler
	}

	// MARK:- View Life Cycle
	override public func viewDidLoad() {
		super.viewDidLoad()
		initUI()
		// Do any additional setup after loading the view.
	}

	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: Private Methods

	private func createSearchBar() {
		if self.tableView.tableHeaderView == nil {
			searchController = UISearchController(searchResultsController: nil)
			searchController.searchResultsUpdater = self
			searchController.dimsBackgroundDuringPresentation = false
			tableView.tableHeaderView = searchController.searchBar
		}
	}

	private func filter(searchText: String) -> [AJCountry] {
		filteredList.removeAll()
		sections.forEach { (section) -> () in
			section.countries.forEach({ (country) -> () in
				if country.name.characters.count >= searchText.characters.count {
					let result = country.name.compare(searchText, options: [.CaseInsensitiveSearch, .DiacriticInsensitiveSearch], range: searchText.startIndex ..< searchText.endIndex)
					if result == .OrderedSame {
						filteredList.append(country)
					}
				}
			})
		}

		return filteredList
	}

	private func initUI() -> Void {
		if showSearchBar {
			createSearchBar()
		}
		filteredList = allCountries
		tableView.reloadData()
	}

}
//MARK:- Table View Data Source
extension AJCountryPicker {

	public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		if searchController.searchBar.isFirstResponder() || !showSection {
			return 1
		}
		return sections.count
	}
	public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if searchController.searchBar.isFirstResponder() || !showSection {
			return filteredList.count
		}
		return sections[section].countries.count
	}
	public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return self.tableView(tableView, countryCellForRowAtIndexPath: indexPath)
	}
	func tableView(tableView: UITableView, countryCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(countryCellIdentifier)
		if cell == nil {
			cell = UITableViewCell(style: .Value1, reuseIdentifier: countryCellIdentifier)
		}

		let country: AJCountry!

		if searchController.searchBar.isFirstResponder() || !showSection {
			country = filteredList[indexPath.row]
		} else {
			country = sections[indexPath.section].countries[indexPath.row]

		}

		cell!.textLabel?.text = country.name
		cell?.textLabel?.font = UIFont.systemFontOfSize(13, weight: 0.1)
		cell!.textLabel?.numberOfLines = 0
		if showCallingCodes {
			cell!.detailTextLabel?.text = country.dialCode
			cell!.detailTextLabel?.font = UIFont.systemFontOfSize(14)
		}

		if showCountryFlags {
			let bundle = "assets.bundle/"
			cell!.imageView!.image = UIImage(named: bundle + country.code.lowercaseString + ".png", inBundle: NSBundle(forClass: AJCountryPicker.self), compatibleWithTraitCollection: nil)
			let itemSize = CGSizeMake(35, 25);
			UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.mainScreen().scale);
			let imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
			cell!.imageView?.image!.drawInRect(imageRect)
			cell!.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();
		}

		return cell!
	}

	override public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if !showSection {
			return ""
		}
		if !sections[section].countries.isEmpty {
			return self.collation.sectionTitles[section] as String
		}
		return ""
	}

	override public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
		if !showSection {
			return []
		}
		return collation.sectionIndexTitles
	}

	override public func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
		if !showSection {
			return 0
		}
		return collation.sectionForSectionIndexTitleAtIndex(index)
	}
}
// MARK: - Table view delegate

extension AJCountryPicker {
	override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		let country: AJCountry!
		if searchController.searchBar.isFirstResponder() {
			country = filteredList[indexPath.row]
		} else {
			country = sections[indexPath.section].countries[indexPath.row]

		}
		delegate?.ajCountryPicker(self, didSelectCountryWithName: country.name, code: country.code)
		delegate?.ajCountryPicker?(self, didSelectCountryWithName: country.name, code: country.code, dialCode: country.dialCode)
		countryWithCode?(country.name, country.code)
		countryWithCodeAndCallingCode?(country.name, country.code, country.dialCode)
		let bundle = "assets.bundle/"
		let image = UIImage(named: bundle + country.code.lowercaseString + ".png", inBundle: NSBundle(forClass: AJCountryPicker.self), compatibleWithTraitCollection: nil)
		countryWithFlagAndCallingCode?(country.name, country.code, country.dialCode, image)
		delegate?.ajCountryPicker?(self, didSelectCountryWithName: country.name, code: country.code, dialCode: country.dialCode, flag: image)
	}
}
// MARK: - UISearchDisplayDelegate
extension AJCountryPicker: UISearchResultsUpdating {
	public func updateSearchResultsForSearchController(searchController: UISearchController) {
		filter(searchController.searchBar.text!)
		tableView.reloadData()
	}
}

