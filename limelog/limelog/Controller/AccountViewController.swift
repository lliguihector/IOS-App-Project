//
//  HomeViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/21/21.
//

import UIKit


class AccountViewController: UITableViewController,Loadable{

    //OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var profileInitialLabel: UILabel!
    @IBOutlet weak var CellButtons: UIView!
    
    //Create an instance of UserManager to fetch api data
    var userManager = UserManager()
 
    //Array to hold menu section titles
    var sectionTitles = ["Profile","Security","Notification Prefrence","Help & Policies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didUpdateUser()
  
        
        //Round of Profile Initials Label
        profileInitialLabel.layer.cornerRadius = profileInitialLabel.frame.size.height / 2
        profileInitialLabel.layer.borderColor = UIColor(red: 55/255.0, green: 124/255.0, blue: 99/255.0, alpha: 1.0).cgColor
        profileInitialLabel.layer.masksToBounds = true
        profileInitialLabel.layer.borderWidth = 2
       
        
       
        
//        tabBarController?.navigationItem.largeTitleDisplayMode = .always
        self.tabBarController?.navigationItem.title = "Account"
       
    }
    
//MARK: - UI TableView DataSource
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 266, height: 30)
        view.backgroundColor = UIColor(red: 241/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
        
       let label = UILabel()
    
        label.textColor = UIColor(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.frame = CGRect(x: 10, y: 0, width: view.frame.size.width, height: 24)
        
        view.addSubview(label)

        label.text = self.sectionTitles[section]
        return view
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
   
    
  
//MARK: - ACTIONS
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Are you shure?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Not now", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sign out", style: .default, handler: {
            action in
            self.signOutUser()
        }))
        self.present(alert, animated: true)
    }
    
    func signOutUser(){
        //Destory JWT Token and user id
        TokenService.tokenInstance.removeToken()
        TokenService.tokenInstance.removeUserID()
        //Takes you to the initial view controller
        navigationController?.popToRootViewController(animated: true)
    }
    
 
    func didUpdateUser(){
    //Get jwt token and userID
        let token = TokenService.tokenInstance.getToken()
        let userID = TokenService.tokenInstance.getUserID()
    
        showLoadingView()
        userManager.getUserByID(userID,token)
        {result in
            
            switch result{
            case.success(let UserModel):
                
                DispatchQueue.main.async{
                
                    self.nameLabel.text = (UserModel.name)
                    self.emailLabel.text = (UserModel.email)
                    self.profileInitialLabel.text = UserModel.initilas
                    self.navigationItem.title = "Hello, \(UserModel.firstName)"
                }

                DispatchQueue.main.async {
                    self.hideLoadingView()
                }
                
            case.failure(let error):
                switch error{
                
                case.requestFailed:
                    print("Network Error")
                    DispatchQueue.main.async {
                        Alert.showBasicAlert(on: self, with: "Error", message: "Network Error")
                        self.hideLoadingView()
                    }
                 
                case .responseFailed:
                    print("Error 400")
                    //Invalid Token Error
                    DispatchQueue.main.async {
                    Alert.showBasicAlert(on: self, with: "Error", message: "Error 400")
                    self.hideLoadingView()
                    }
                case .jsonDecodingFailed:
                    print("Decoding problem")
                    DispatchQueue.main.async {
                    Alert.showBasicAlert(on: self, with: "Error", message: "JSON Decoding Error")
                    self.hideLoadingView()
                    }
                case .invalidUrl:
                    print("userID problem")
                    DispatchQueue.main.async {
                    Alert.showBasicAlert(on: self, with: "Error", message: "Invalid User ID")
                    self.hideLoadingView()
                    }
                }
            }
        }
    }
  
}


