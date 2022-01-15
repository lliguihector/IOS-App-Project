//
//  Alert.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/17/21.
//

import Foundation
import UIKit


struct Alert {
    
    //Resource URL: https://www.youtube.com/watch?v=ZBS2uRP6_2U
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
 
        
    }
    
    
    
    
    
    
}
