//
//  AJCountry.swift
//  AJCountryPicker
//
//  Created by Aj Mehra on 25/07/16.
//  Copyright © 2016 TeamAj. All rights reserved.
//

import Foundation

class AJCountry :NSObject {
    
    var name :String
    var code :String
    var section :Int?
    var dialCode :String
    
    init(name: String = "", code: String, dialCode: String = " - ") {
        self.name = name
        self.code = code
        self.dialCode = dialCode
    }
    
}

struct Section {
    
    var countries = [AJCountry]()
    mutating func addCountry(country: AJCountry) -> Void {
        countries.append(country)
    }
}



