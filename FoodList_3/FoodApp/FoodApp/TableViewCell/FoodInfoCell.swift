//
//  FoodInfoCell.swift
//  FoodApp
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class FoodInfoCell: UITableViewCell {

    @IBOutlet weak var lblTitle : UILabel?
    @IBOutlet weak var lblLifeSpan : UILabel?
    @IBOutlet weak var lblFoodFor : UILabel?
    @IBOutlet weak var ivDog : UIImageView?
    @IBOutlet weak var btnFav : UIButton?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setupData(objFoodnfo: FoodInfo)
    
    {
        //if(objFoodnfo.Foods?.count ?? 0 > 0)
       // {
          //  let objFoodInfo :  Food? = objFoodnfo.Foods?[0]
        self.lblTitle?.text = String(format: "Name: %@", objFoodnfo.strMeal ?? "")
        self.lblLifeSpan?.text = String(format: "Category: %@", objFoodnfo.strCategory ?? "")
        self.lblFoodFor?.text = String(format: "Tags: %@", objFoodnfo.strTags ?? "")
        //}
        
        if(objFoodnfo.isFav == false)
        {
            self.btnFav?.isSelected = false
        }
        else
        {
            self.btnFav?.isSelected = true

        }
        
        let strURL : String? = String(format: "%@",objFoodnfo.strMealThumb ?? String() )
        let url = URL(string: strURL ?? String())
        
        self.ivDog?.sd_setImage(with: url, placeholderImage:nil, completed: { (image, error, cacheType, url) -> Void in
            if ((error) != nil)
            {
                self.ivDog?.image  = UIImage(named:"No_Image_Found")
                
            } else
            {
                self.ivDog?.image = image
            }
        })
        
    
    }

}
