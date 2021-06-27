//
//  FoodView.swift
//  FoodApp
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//
import Foundation
import UIKit


protocol FoodView{
     func startLoading()
	 func finishLoading()
     func setFoodData(Food: [FoodInfo])
}
