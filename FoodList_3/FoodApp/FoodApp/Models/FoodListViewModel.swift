//
//  FoodListViewModel.swift
//  FoodApp
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class FoodListViewModel: NSObject {
    
    
    private var foodService : FoodService
    var arrFoodsAscending : [FoodInfo]? = []
    var arrFoodsDesending : [FoodInfo]? = []
    var arrFoods : [FoodInfo]? = []
    var FoodView : FoodView?
    func attachView(view: FoodView) {
        FoodView = view
    }
    
    func detachView() {
        FoodView = nil
    }
    init(Foodservice :FoodService) {
        
        self.foodService = Foodservice
        super.init()
        populateSources()
    }
    
    func populateSources() {
        
        if(Helper.sharedInstance.checkIntenetConnection() == true)
        {
            self.FoodView?.startLoading()
            let strURL = String(format: "%@",kBaseURL)
            print("Food info url",strURL)
            FoodService.getWebServiceCall(kBaseURL, headerPrm: nil, isShowLoader: true, success: { (response) in
                let data = response.data
                // your failure handle
                var error:Error?
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print("converted data is",jsonResponse as! NSDictionary)
                    var dict = jsonResponse as! NSDictionary
                    var arrMealsModel : FoodInfoAlias? = []
                    var arrMeals : [AnyObject]  = dict["meals"] as! [AnyObject]
                    print("arrMeals is",arrMeals)
                    for objMeal in arrMeals
                    {
                        var objModel: FoodInfo? = FoodInfo()
                        objModel?.idMeal = objMeal["idMeal"] as! String
                        objModel?.strMeal = objMeal["strMeal"] as! String
                        objModel?.strCategory = objMeal["strCategory"] as! String
                        objModel?.strInstructions = objMeal["strInstructions"] as! String
                        objModel?.strMealThumb = objMeal["strMealThumb"] as! String
                        if let tempTag  = objMeal["strTags"] as? String
                        {
                        objModel?.strTags = tempTag
                        }
                        objModel?.strArea = objMeal["strArea"] as! String
                        arrMealsModel?.append(objModel!)
                        print("objmeal is",objModel)

                    }
                    if(arrMealsModel != nil)
                    {
                        self.FoodView?.setFoodData(Food:arrMealsModel!)
                    }
                    DispatchQueue.main.async { () -> Void in
                        
                        self.FoodView?.finishLoading()
                    }

                  //  var arrMeals : FoodInfoAlias = dict["meals"] as! FoodInfoAlias
                    //print("arrMeals are",arrMeals)

                }
                catch let error
                {
                    print(error)
                }

                

                /*do
                {
                    
                    var dictFoodInfo : FoodInfoAlias!
                   // let decoder = JSONDecoder()
                    //dictFoodInfo = try decoder.decode(FoodInfoAlias.self, from: data!)
                    //print("codable dict is",dictFoodInfo)
                    
                    var index : Int = 0
                   /* for var objFoodInfo in dictFoodInfo
                    {
                        if(objFoodInfo.Foods?.count ?? 0 > 0)
                        {
                            
                            let objFoodInfoDetail :  Food? = objFoodInfo.Foods?[0]
                            let arrTemp = objFoodInfoDetail?.lifeSpan?.components(separatedBy: " ")
                            if(arrTemp?.count ?? 0 > 0)
                            {
                                
                                let stLifeSpan = Int(arrTemp?[0] ?? "")
                                objFoodInfo.strLifeSpan = stLifeSpan
                            }
                            if(arrTemp?.count ?? 0 > 2)
                            {
                                
                                let endLifeSpan = Int(arrTemp?[2] ?? "")
                                objFoodInfo.strLifeEnd = endLifeSpan
                                
                            }
                            
                            self.arrFoods?.append(objFoodInfo)
                            index = index + 1
                            
                        }
                        
                    }*/
                    
                    
                    print("arr Food is",self.arrFoods)
                    /*let sortedArray1 = self.arrFoods?.sorted {
                        $0.strLifeSpan ?? 0 < $1.strLifeSpan ?? 0
                    }*/
                    
                    if(self.arrFoods != nil)
                    {
                    self.FoodView?.setFoodData(Food: self.arrFoods!)
                    }
                    DispatchQueue.main.async { () -> Void in
                        
                        self.FoodView?.finishLoading()
                    }
                }
                catch
                {
                    DispatchQueue.main.async { () -> Void in
                        self.FoodView?.finishLoading()
                    }
                    print("exception occured while parsing data",error.localizedDescription)
                }*/
                
                
                
                
            }){ (ERROR) in
                DispatchQueue.main.async { () -> Void in
                    
                    self.FoodView?.finishLoading()
                }
                print(ERROR.localizedDescription)
            }
            
        }
        else
        {
            //  self.displayNoInternetAlert()
            //return
            
        }
    }
    
   /* func sortAscending(dictFoodInfo:[FoodInfo])
    {
        
        let sortedArray = arrFoods?.sorted {
            $0.strLifeSpan ?? 0 < $1.strLifeSpan ?? 0
        }
        self.arrFoodsAscending = sortedArray
       // print("sorted array  ascending is",arrFoodsAscending)
        
        
    }*/
    
    
   /* func sortDescending(dictFoodInfo:[FoodInfo])
    {
        
        let sortedArray = arrFoods?.sorted {
            $0.strLifeSpan ?? 0 > $1.strLifeSpan ?? 0
        }
        self.arrFoodsDesending = sortedArray
       // print("sorted array  descending is",arrFoodsDesending)
        
    }*/
    
    
}


