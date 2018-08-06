//
//  AJCountryPicker.swift
//  AjCountryPicker
//
//  Created by Ajay Mehra on 06/08/18.
//  Copyright © 2018 Aisha Technologies. All rights reserved.
//

import UIKit

class AJCountryPicker: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var searchBarHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    public var customCountriesCodes: [String]?
    public var showCountryFlags: Bool = true
    public var showIndexedSections: Bool = false
    public var showSearchBar: Bool = false
    public var showCallingCodes: Bool = false
    public var country: ((Country) -> ())?
    
    // MARK: - Private properties
    
    private var items: [Country] = []
    
    private var countries: [Country] {
        return CountryProvider.countries(customCountriesCode: customCountriesCodes)
    }
    
    var isPresented:Bool {
        if self.presentingViewController != nil, self.presentingViewController?.presentedViewController == self,  self.navigationController?.presentingViewController?.presentedViewController == self.navigationController, self.tabBarController?.presentingViewController is UITabBarController  {
            return true
        }else {
            return false
        }
    }
    
    // MARK: - Private Methods
    
    private func filter(with searchText: String) {
        items = countries.filter({ (country) -> Bool in
            country.name.compare(searchText, options: [.caseInsensitive, .diacriticInsensitive], range: searchText.startIndex ..< searchText.endIndex) == .orderedSame
        })
        tableView.reloadData()
    }
    
    private func initUI() {
        searchBarHeightConstraint.constant = showSearchBar ? 56 : 0
        tableView.register(cellType: CountryTableViewCell.self)
        items = countries
        tableView.tableFooterView = .init()
        tableView.reloadData()
    }
    
    // MARK: - Overrided Methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table view data source

extension AJCountryPicker: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CountryTableViewCell
        let country: Country = items[indexPath.row]
        cell.configure(with: country, showCallingCode: showCallingCodes, showFlag: showCountryFlags)
        return cell
    }
}

// MARK: - Table view delegate

extension AJCountryPicker: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        country?(items[indexPath.row])
        if isPresented {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension AJCountryPicker: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(with: searchText)
    }
}
