//
//  StoreHoursViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/9/21.
//

import Foundation
import UIKit

class StoreHoursViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var closebtn: UIButton!
    
    var  days = ["Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday","Sunday"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the Navigation Bar Titlte
        navigationItem.title = "Store Schedual"
        tableView.delegate  = self
        tableView.dataSource = self

        //Register Custome xib file
        tableView.register(UINib(nibName: "StoreScheduleCell", bundle: nil), forCellReuseIdentifier: "StoreScheduleReusableCell")
      
        tableView.layer.cornerRadius = 4
   

    }
    
    
    
    
    @IBAction func closeView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}


extension StoreHoursViewController: UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        days.count
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreScheduleReusableCell", for: indexPath)
        as! StoreScheduleCell
        
        
        cell.daysLabel.text = days[indexPath.row]
        
        return cell
    }
    
    
 
    
    
    
}


extension StoreHoursViewController: UITableViewDelegate{
    
    
    
    
}
