//
//  PLUListViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 1/5/22.
//

import Foundation
import UIKit



class PLUListViewController: UIViewController, Loadable{
    
    //OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    private var plulist: [PLU] = []
    
    var pluListManager = PluListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        
        
        configureRefreshControl()
        
        tableView.register(UINib(nibName: "PLUTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "PLUCell")
    
        fetchPLUListData()
        
    }
    
    
    func configureRefreshControl() {
       // Add the refresh control to your UIScrollView object.
        
       tableView.refreshControl = UIRefreshControl()
       tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    
    @objc func handleRefreshControl() {
       // Update your content…
    fetchPLUListData()
       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.tableView.refreshControl?.endRefreshing()
       }
    }
    
    func fetchPLUListData(){
        
        showLoadingView()
        
        
        pluListManager.getPluList(url: constant.plulistUrl, expecting: [PLU].self)
        {[weak self] result in
            
            switch result{
            
            case.success(let plu):
                
                DispatchQueue.main.async {
                    self?.plulist = plu
                    self?.tableView.reloadData()
                }
                
                DispatchQueue.main.async {
                    self?.hideLoadingView()
                }
                
            case.failure(let error):
                switch error {
                case  .invalidURL:
                    print("url error")
                    
                    
                case.requestFailed:
                    DispatchQueue.main.async {
                        Alert.showBasicAlert(on: self!, with:"", message: "Couldn't connect to the server.")
                        self?.hideLoadingView()
                    }

                    DispatchQueue.main.async {
                        self?.hideLoadingView()
                    }
                    print("Network Error")
                case.responseFailed:
                    print("Error 400")
                case.jsonDecodingFailed:
                    print("Decoding pronlem")
                case.invalidImageURL:
                    print("URL Image Error!")
                }
            }
    }
}
}

    
//MARK: - Table View Data Source
extension PLUListViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return plulist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PLUCell", for: indexPath) as! PLUTableViewCell
        
        cell.produceName.text = plulist[indexPath.row].name
        cell.produceCode.text = plulist[indexPath.row].plucode
        
        return cell
        
    }
    
    
    
}
