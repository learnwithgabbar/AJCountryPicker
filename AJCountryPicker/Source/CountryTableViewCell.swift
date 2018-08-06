//
//  CountryTableViewCell.swift
//  AjCountryPicker
//
//  Created by Ajay Mehra on 06/08/18.
//  Copyright © 2018 Aisha Technologies. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell, NibReusable {
    // MARK: - IBOutlets

    @IBOutlet private var countryNamelabel: UILabel!
    @IBOutlet private var iSOCodelabel: UILabel!
    @IBOutlet private var callingCodelabel: UILabel!
    @IBOutlet private var flagImageView: UIImageView!
    @IBOutlet private var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var callingCodeWidthConstraint: NSLayoutConstraint!

    // MARK: - Configure Cell

    func configure(with item: Country, showCallingCode: Bool, showFlag: Bool) {
        selectionStyle = .none
        countryNamelabel.text = item.name
        iSOCodelabel.text = item.ISOCode
        callingCodelabel.text = item.callingCode
        flagImageView.image = UIImage.init(named: item.flagURl)
        imageViewWidthConstraint.constant = showFlag ? 40 : 0
        callingCodeWidthConstraint.constant = showCallingCode ? 90 : 0
    }
}
