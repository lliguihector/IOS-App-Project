//
//  ProductCell.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/4/21.
//

import UIKit

class ProductCell: UITableViewCell {

    //OUTLETS 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
