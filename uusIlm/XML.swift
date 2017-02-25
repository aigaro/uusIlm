//
//  XML.swift
//  uusIlm
//
//  Created by Aigar on 22/02/17.
//  Copyright © 2017 Aigar. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash


class ilmaAndmed: NSObject {
    
    var weatherDict: [String] = ["null", "üks", "kaks", "kolm", "neli", "viis", "kuus", "seitse", "kaheksa", "üheksa", "kümme", "üksteist", "kaksteist", "kolmteist", "neliteist", "viisteist", "kuusteist", "seitseteist", "kaheksateist", "üheksateist", "kakskümmend", "kakskümmend üks", "kakskümmend kaks", "kakskümmend kolm", "kakskümmend neli", "kakskümmend viis", "kakskümmend kuus", "kakskümmend seitse", "kakskümmend kaheksa", "kakskümmend üheksa", "kolmkümmend"]
    var tempMin_day = Int()
    var tempMax_day = Int()
    var ilmTekst_day = String()
    var windMin_day = Int()
    var windMax_day = Int()
    var ilmKuupaev = Date()
    var rida_min = [Int]()
    var rida_max = [Int]()
    
    var tempMin_night = Int()
    var tempMax_night = Int()
    var ilmTekst_night = String()
    var windMin_night = Int()
    var windMax_night = Int()
    
    
    
}

