//
//  customeTextField.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/25/21.
//

import UIKit

class customeTextFiled: UITextField {
 
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
   
            let bottomLine = CALayer()
            
            bottomLine.frame = CGRect(x: 0, y: self.frame.height - 11  , width: self.frame.size.width , height: -0.5)
    
            bottomLine.backgroundColor = UIColor.init(red: 29/255, green: 133/255, blue: 65/255, alpha: 1).cgColor
    
            //Remove boarder on text field
            self.borderStyle = .none
    
            //Add the line to the Text field
           self.layer.addSublayer(bottomLine)
    
        }

}
