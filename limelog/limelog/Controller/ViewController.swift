//
//  ViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/10/21.
//

import UIKit

class ViewController: UITabBarController,Loadable{
    
    //-------  OUTLETS --------
   
    var userManager = UserManager()
    var globalText = "Global Variable from Tab Bar View Controller"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self

//        loadAllDataResources()
        
        navigationItem.hidesBackButton = true
//        title = "Determit"
     
        
        
    }
    
    
    func loadAllDataResources(){
        
        showLoadingView()
        
        
        userManager.fetchResources()
        
    }
    
    
}


//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    

}

////MARK: - UserManagerDelegate
extension ViewController: UserManagerDelegate{
    func finishDispatch() {
        hideLoadingView()
    }
    
  
    
    //UPDATE UI WITH USER DATA
    func didUpdateUser(_ userManager: UserManager, user: UserModel) {
        // print(user.id)
        DispatchQueue.main.async {
//            self.getApiDataTestScreen.text = "Welcome Back! \(user.name)"
//            self.nameTextField.text = user.name
//            self.emailTextField.text = user.email
//            self.passwordTextField.text = user.password
        }
    }

    func didFailWithError(error: Error) {
//        print(error)

        DispatchQueue.main.async {
            Alert.showBasicAlert(on: self, with: "error", message: error.localizedDescription)
//        self.getApiDataTestScreen.text = "\(error)"
        }
    }
}
