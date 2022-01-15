//
//  NewsFeedCell.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/4/21.
//

import UIKit

class NewsFeedCell: UITableViewCell {

    
   //OUTLETS
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var CompanyImagePostView: UIImageView!
    @IBOutlet weak var companyPostTitleLabel: UILabel!
    @IBOutlet weak var companyPostDetailsLabel: UILabel!
    @IBOutlet weak var cellBackGroundView: UIView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        //Style Company Profile Pic
        companyImageView.layer.cornerRadius = companyImageView.frame.size.height / 2
        
        companyImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        
        companyImageView.layer.masksToBounds = true
        companyImageView.layer.borderWidth = 0.5
        
        //Style cell view
        
        
        cellBackGroundView.layer.cornerRadius = 4
        cellBackGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        cellBackGroundView.layer.shadowOpacity = 0.5
        cellBackGroundView.layer.shadowOffset = .zero
        cellBackGroundView.layer.shadowRadius = 1
        
        
        
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
