//
//  Common.swift
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.

import Foundation
import UIKit


//let kBaseURL = "https://api.thedogapi.com/v1/images/search?limit=50"
let kBaseURL = "https://www.themealdb.com/api/json/v1/1/search.php?f=a"


class Common: NSObject {
    static let sharedInstance: Common = {
        let instance = Common()
        // setup code
        return instance
    }()
}

