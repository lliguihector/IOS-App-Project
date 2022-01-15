//
//  AccountIDViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 10/7/21.
//

import Foundation
import UIKit

class AccountIDViewController: UIViewController{
    
    @IBOutlet weak var AccountIdLabel: UILabel!
    
    let userID = TokenService.tokenInstance.getUserID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
            
        

            AccountIdLabel.text = userID
        
       
        
        
      
    }
    
    
    
    
    
    
    
}
