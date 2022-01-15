//
//  UserPersonalnfoViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 7/12/21.
//

import Foundation
import UIKit

class UserPersonalInfoViewController: UIViewController {
    
//OUTLETS
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var userManager = UserManager()
    let userID = TokenService.tokenInstance.getUserID()
    
    //--- VIEW DID LOAD ---
    override func viewDidLoad() {
        super.viewDidLoad()
        

        userFirstNameTextField.delegate = self
        userLastNameTextField.delegate = self
        userEmailTextField.delegate = self
        
        //DISABLE BUTTON
//        saveButton.isEnabled = false
//        saveButton.isHidden = true
//        saveButton.alpha = 0.5
//        saveButton.layer.cornerRadius = 5
//        saveButton.layer.shadowRadius = 10
//        saveButton.layer.shadowOpacity = 0.3
        getUserPersonalInfo()
        
        
        
       
    
    }
    
    
    
    
    
    
    
    
    //SAVE BUTTON PRESSED
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        //Show Action Sheet
        let alert = UIAlertController(title: "Update info", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in

         //Return to previus view controller
           
            
               
        }))
        
        
        self.present(alert, animated: true)
        //Udate personal info
        print("Button is Pressed")
        
    }


    
}
//MARK: - UITextFieldDelegate
extension UserPersonalInfoViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //Enable save Button
//        saveButton.isEnabled = true
//        saveButton.isHidden = false
//        saveButton.alpha = 1
    }
    

    
}
//MARK: - UserManager
extension UserPersonalInfoViewController {
    
    func getUserPersonalInfo(){
        
        userManager.fetchUsersInfo(userID)
        {result in
            
            switch result{
            case.success(let PersonalInfoModel):
                
                
                DispatchQueue.main.async {
                    print(PersonalInfoModel)
                    self.userFirstNameTextField.text = (PersonalInfoModel.firstName)
                    self.userLastNameTextField.text = (PersonalInfoModel.lastName)
                    self.userEmailTextField.text = (PersonalInfoModel.userIdRef)
                }
                
            case.failure(let error):
                switch error{
                case.requestFailed:
                    print("Network Error")
                case .responseFailed:
                    print("Error 400")
                    //Invalid Token Error
                case .jsonDecodingFailed:
                    print("Decoding problem")
                case .invalidUrl:
                    print("userID problem")
                }
            }
        }
    }
    
}

