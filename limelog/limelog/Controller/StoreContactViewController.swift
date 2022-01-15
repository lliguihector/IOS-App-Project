//
//  StoreContactViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 10/24/21.
//

import UIKit
import MapKit

class StoreContactViewController: UIViewController {

    //Outlets
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        styleBtns(btn1)
        styleBtns(btn2)
        styleBtns(btn3)
        styleBtns(btn4)
        styleBtns(btn5)
        
        
    }
    
    
    func styleBtns(_ btn: UIButton){
        
        
        
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        
    }


}
