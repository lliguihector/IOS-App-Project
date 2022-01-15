//
//  PLUTableViewCell.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 1/5/22.
//

import UIKit

class PLUTableViewCell: UITableViewCell {

    
    @IBOutlet weak var produceName: UILabel!
    @IBOutlet weak var produceCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
