//
//  FoodDetailVC.swift
//  FoodApp
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class FoodDetailVC: UIViewController
{
    
    var objFoodDetail : FoodInfo?
    var imgFood : UIImage?
    @IBOutlet weak var tblFoodDetail : UITableView?
    
    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }
    
    func commonInit()  {
        self.title =  "Food Detail"
        tblFoodDetail?.estimatedRowHeight = 100
        tblFoodDetail?.rowHeight = UITableView.automaticDimension
        
    }
    
    
    
    @objc func imageTapped(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "FoodDetailToImage", sender: self)
    }
    
    //MARK: Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Set Data
    func setFoodDetail(Food:FoodInfo)
    {
        self.objFoodDetail = Food
    }
    
    
    //MARK: Navigation

    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "FoodDetailToImage")
        {
            let objVC : ImageViewVC = segue.destination  as! ImageViewVC
            objVC.setImageDetail(image: self.imgFood!)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension FoodDetailVC : UITableViewDelegate,UITableViewDataSource

{
    //MARK: UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : FoodDetailCell = tableView.dequeueReusableCell(withIdentifier: "FoodDetailCell", for: indexPath) as! FoodDetailCell
        let strURL = String(format: "%@",(self.objFoodDetail?.strMealThumb)!)
        print("string url is",strURL)
       let tap = UITapGestureRecognizer(target: self, action: #selector(FoodDetailVC.imageTapped))
        cell.ivFoodImage?.isUserInteractionEnabled = true
        cell.ivFoodImage?.addGestureRecognizer(tap)
        
        let url = URL(string: strURL)
        
        //if(self.objFoodDetail?.Foods?.count ?? 0 > 0)
        //{
           // let objFoodInfo :  Food? = self.objFoodDetail?.Foods?[0]
            cell.lblName?.text = String(format: "Name: %@", objFoodDetail?.strMeal ?? "")
            cell.lblLifeSpan?.text = String(format: "Category: %@", objFoodDetail?.strCategory ?? "")
            cell.lblFoodFor?.text = String(format: "Tags: %@", objFoodDetail?.strTags ?? "")
            cell.lblTemperament?.text = String(format: "Instructions: %@", objFoodDetail?.strInstructions ?? "")
            cell.lblFoodGroup?.text = String(format: "Area: %@", objFoodDetail?.strArea ?? "")
       // }
        cell.ivFoodImage?.sd_setImage(with: url, placeholderImage:nil, completed: { (image, error, cacheType, url) -> Void in
            if ((error) != nil)
            {
                cell.ivFoodImage?.image  = UIImage(named:"No_Image_Found")
                self.imgFood = cell.ivFoodImage?.image
                // set the placeholder image here
                
            } else
            {
                cell.ivFoodImage?.image = image
                self.imgFood = cell.ivFoodImage?.image
            }
        })
        
        return cell
    }
    
    
    
    
    
}
