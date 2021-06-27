//
//  FoodDetailCell.swift
//  FoodApp
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class FoodDetailCell: UITableViewCell {

    
    
    @IBOutlet weak var viewContainer : UIView?
    @IBOutlet weak var ivFoodImage : UIImageView?
    @IBOutlet weak var lblName : UILabel?
    @IBOutlet weak var lblLifeSpan : UILabel?
    @IBOutlet weak var lblFoodFor : UILabel?
    @IBOutlet weak var lblTemperament : UILabel?
    @IBOutlet weak var lblFoodGroup : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
