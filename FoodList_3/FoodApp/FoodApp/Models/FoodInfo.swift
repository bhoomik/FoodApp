//
//  FoodInfo.swift
//  Bhoomi_Kathiriya
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct FoodInfo: Codable {
   // let Foods: [Food]?
    var idMeal: String?
    var strMeal: String?
    var strCategory: String?
    var strInstructions: String?
    var strMealThumb: String?
    var strTags: String?
    var strArea :String?
    var isFav : Bool  = false



//    let width, height: Int?
//    var strLifeSpan : Int?
//    var strLifeEnd : Int?

}

// MARK: - Food

// MARK: - Eight
struct Eight: Codable {
    let imperial, metric: String?
}

typealias FoodInfoAlias = [FoodInfo]


