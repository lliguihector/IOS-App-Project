//
//  CategoryCell.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 10/25/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    //OUTLETS
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        categoryImage.layer.cornerRadius = categoryImage.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
