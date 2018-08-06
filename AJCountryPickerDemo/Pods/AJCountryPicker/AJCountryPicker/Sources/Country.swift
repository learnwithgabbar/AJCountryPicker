//
//  Country.swift
//  AjCountryPicker
//
//  Created by Ajay Mehra on 06/08/18.
//  Copyright © 2018 Aisha Technologies. All rights reserved.
//

import Foundation

public class Country: NSObject {
    @objc public var name: String
    public var ISOCode: String
    public var callingCode: String
    public var flagURl: String

    init(name: String, ISOCode: String, callingCode: String) {
        self.name = name
        self.ISOCode = ISOCode
        self.callingCode = callingCode
        self.flagURl = "assets.bundle/" + ISOCode.lowercased() + ".png"
    }
}
