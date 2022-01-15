//
//  RegisterUserViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/24/21.
//

import UIKit

class RegisterUserViewController: UIViewController{
    
    
    
    //OUTLITS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var confirmPasswordTextField: customeTextFiled!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var labelView: UIImageView!
    @IBOutlet var collection:[UIImageView]!
    
    
    var postRequest = RegisterUserManager()
    var validation = Validation()
    
    var pass: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       //Set custome Icon Labels inside textFields
        setIconLabel(firstNameTextField, "person",.lightGray)
        setIconLabel(lastNameTextField, "person",.lightGray)
        setIconLabel(emailTextField, "envelope",.lightGray)
        setIconLabel(passwordTextFiled, "key",.lightGray)
        setIconLabel(confirmPasswordTextField, "key",.lightGray)
        
        postRequest.delegate = self
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextFiled.delegate = self
        confirmPasswordTextField.delegate = self
        
    
        
        firstNameTextField.addTarget(self, action: #selector( checkAndDisplayError(textField:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector( checkAndDisplayError(textField:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector( checkAndDisplayError(textField:)), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector( checkAndDisplayError(textField:)), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector( checkAndDisplayError(textField:)), for: .editingChanged)
        
    
        //STYLE sign up button
        signUpButton.layer.cornerRadius = 2
        
    }
    
    //ACTION
    @IBAction func registerPressed(_ sender: UIButton){
        
        if let firstName = firstNameTextField.text , let lastName = lastNameTextField.text ,let email = emailTextField.text, let password = passwordTextFiled.text, let confirmPass = confirmPasswordTextField.text{
            
            
            
            //1.VALIDATE USER INPUT
    
            //Trim any empty spaces
          let trimedfirstName = validation.trimWhiteSpaces(str: firstName)
          let trimedLastName = validation.trimWhiteSpaces(str: lastName)
            
            let isValidateFirstName = self.validation.validateName(name: trimedfirstName)
            if(isValidateFirstName == false){
                Alert.showBasicAlert(on: self, with: "Missing Field", message: "Please enter a First Name (minimum 3 charaters)")
                print(isValidateFirstName)
                return
            }
            let isValidateLastName = self.validation.validateName(name: trimedLastName)
            if(isValidateLastName == false){
                Alert.showBasicAlert(on: self, with: "Missing Field", message: "Please enter a Last Name (minimum 3 characters)")
                print(isValidateLastName)
                return
            }
            
            let isValidateEmail = self.validation.validateEmail(email: email)
            if(isValidateEmail == false){
                Alert.showBasicAlert(on: self, with: "Format", message: "Please enter a valid email address")
                print(isValidateEmail)
                return
            }
            let isValidatePassword = self.validation.validatePassword(password: password)
            if(isValidatePassword == false){
                Alert.showBasicAlert(on: self, with: "Format", message: "Incorect Password Format Minimum 6 characters at least 1 Alpabet and 1 Number")
                print(isValidatePassword)
                return
            }
            
            if confirmPass != password{
                Alert.showBasicAlert(on: self, with: "Error", message: "Passwords do not match")
            }
            

            //Concatenation first name and last name
            let fullName = "\(firstName) \(lastName)"
            print(fullName)
            //CREATE A NewUserData Object
            let newUserInfo = NewUserData(name: fullName, email: email, password: password)
            
            //Make a POST API call and Regiter new user
            postRequest.createUser(newUserInfo) { result in
                switch result{
                case .success(let newUser):
                    
                    
                    print("New User Was Created \(newUser._id)")
                    DispatchQueue.main.async {
                        Alert.showBasicAlert(on: self, with: "Success", message: "New User Was Created ID: \(newUser._id)")
                    }
                    
            
                case .failure(let error):
                    switch error{
                    case .requestFailed:
                        print("Network Problem")
                    case .responseFailed:
                        print("Error 400")
                    case .jsonDecodingFailed:
                        print("Decoding problem")
                    case .jsonEncodingFailed:
                        print("encoding problem")
                    }
                }
            }
        }
    }
}


//MARK: - UITextFieldDelegate
extension RegisterUserViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button
        //        signUpButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextFiled.becomeFirstResponder()
        case passwordTextFiled:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            confirmPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
    @objc func checkAndDisplayError(textField: UITextField){
        
        if textField == firstNameTextField {
            
            if textField.text != "" && textField.text!.count >= 3{
                setIconLabel(firstNameTextField, "person.fill",.black)
                
            }else{
                setIconLabel(firstNameTextField, "person",.lightGray)
            }
        }
        
        if textField == lastNameTextField
        {
            if textField.text != "" && textField.text!.count >= 3{
                setIconLabel(lastNameTextField, "person.fill",.black)
            }else {
                setIconLabel(lastNameTextField, "person",.lightGray)
            }
            
        }
        
        if textField == emailTextField
        
        {
            if textField.text != ""{
                setIconLabel(emailTextField, "envelope.fill",.black)
            }else{
                setIconLabel(emailTextField, "envelope",.lightGray)
                
            }
        }
        
        if textField == passwordTextFiled{
            pass = textField.text!
            print(pass)
            if textField.text != ""{
                setIconLabel(passwordTextFiled, "key.fill",.black)
            }else{
                setIconLabel(passwordTextFiled, "key",.lightGray)
            }
            if confirmPasswordTextField.text != pass {
                setIconLabel(confirmPasswordTextField, "key",.red)
            }else{
                setIconLabel(confirmPasswordTextField, "key",.lightGray)
            }
        }
        if textField == confirmPasswordTextField{
            if textField.text != ""{
                setIconLabel(confirmPasswordTextField, "key.fill",.black)
            }else{
                setIconLabel(confirmPasswordTextField, "key",.lightGray)
            }
            if textField.text != pass {
                setIconLabel(confirmPasswordTextField, "key.fill",.red)
            }else{
                setIconLabel(confirmPasswordTextField, "key.fill",.black)
            }
        }
    }
}

func setIconLabel(_ textField: UITextField, _ sfSymbol: String, _ tintColor: UIColor){
    
   let icon = sfSymbol
   let color = tintColor
    
    //Add Icons inside email text field
    let imageIcon = UIImageView()
    imageIcon.image = UIImage(systemName: icon)
    imageIcon.tintColor = color
    let contentView = UIView()
    contentView.addSubview(imageIcon)

    contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName:  icon)!.size.width , height: UIImage(systemName:  icon)!.size.height)
    imageIcon.frame = CGRect(x: 0, y: 0, width: UIImage(systemName:  icon)!.size.width, height: UIImage(systemName:  icon)!.size.height)
   
    textField.leftView = contentView
    textField.leftViewMode = .always

}

//MARK: - RegistrationUserManagerDelegate
extension RegisterUserViewController: RegisterUserManagerDelegate{
    
    func responseError(responseError: String){
        DispatchQueue.main.async {
            Alert.showBasicAlert(on: self, with: "error", message: responseError)
        }
    }
    
    
    func didFailWithError(error: Error) {
        //print(error)
        
        DispatchQueue.main.async {
            Alert.showBasicAlert(on: self, with: "error", message: error.localizedDescription)
        }
    }
}




