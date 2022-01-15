//
//  LoginViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/17/21.
//

import UIKit
import LocalAuthentication
import JWTDecode
class  LoginViewController: UIViewController, Loadable{
    
    //OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    /// An authentication context stored at class scope so its available for use during UI update.
    var context = LAContext()
    
    
    /// The available states of being logged in or not.
    enum AuthenticationState{
        case loggedin, loggedout
    }
    
    
    var eyeClick = false
    
    
    private let state =  true
    

    var postRequest = LoginManager(endpoint: "api/user/login")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigate user to HomeScreen if he is loged in
//        if UserDefaults.standard.object(forKey: constant.token) != nil{
//            navigateToHomeVc()
//        }
        
        if state {
            navigateToHomeVc()
        }
        
        //Display custome icons inside textFields
        displayIconOnLeftTextFieldView("person", emailTextField)
        emailTextField.clearButtonMode = .whileEditing
        displayIconOnLeftTextFieldView("lock", passwordTextFiled)
        
        //Add toggle eye Icon on left side inside password texfieldView
        displayPasswordToggleIcon()
    
        //Style text Fields
        loginButton.layer.cornerRadius = 2
        registerButton.layer.cornerRadius = 2
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
    //Resign keyboard on touch any where
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextFiled.resignFirstResponder()
    }
    
 
   
    
//LOGIN BUTTON
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text , let password = passwordTextFiled.text{
            showLoadingView()
            let user = LoginData(email: email, password: password)
            sigIn( user)
        }
}

        

    func sigIn(_ user: LoginData){
            
//        let defaults = UserDefaults.standard
            postRequest.loginUser(user) { result in
                switch result{
                case .success(let token):
                    
                 //SET JWT IN USER DEFAULTS
                    TokenService.tokenInstance.saveToke(token)
                    
                    //DECODE JWT AND GET PAYLOAD
                    do{
                        let jwt = try decode(jwt: token)
                        
                        let claim = jwt.claim(name: "_id")
                        
                        if let id = claim.string{
                            //SET USER ID IN USER DEFAULTS
                            TokenService.tokenInstance.saveUserID(id)
                        }
                   
                    } catch {
                        
                        print("Error trying to decode jwt claim")
                    }
                    DispatchQueue.main.async {
                        self.hideLoadingView()
                    }
                    
                    //If JWT Matches Login the user and display the home screen
                    DispatchQueue.main.async {
                        
                        self.performSegue(withIdentifier: constant.loginToHomeSegue, sender: self)
                        
                    }
                   
                case .failure(let error):
                    switch error{
                    case .requestFailed:
                        
                        DispatchQueue.main.async {
                            self.hideLoadingView()
                        }
                        DispatchQueue.main.async {
                            Alert.showBasicAlert(on: self, with:"", message: "Couldn't connect to the server.")
                        }
                        print("Network Problem")
                        
                    case .responseFailed:
                        DispatchQueue.main.async {
                            self.hideLoadingView()
                        }
                        print("Error 400")
                        DispatchQueue.main.async {
                            Alert.showBasicAlert(on: self, with: "Server Error", message: "Email Or Password dont match")
                        }
                    case .jsonDecodingFailed:
                        DispatchQueue.main.async {
                            self.hideLoadingView()
                        }
                        print("Decoding problem")
                    case .invalidCredentials:
                        
                        print("JWT problem")
                        
                    case .jsonEncodingFailed:
                        DispatchQueue.main.async {
                            self.hideLoadingView()
                        }
                        print("encoding problem")

                    }
                }
            }
        }


    func navigateToHomeVc(){
     let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! ViewController
     self.navigationController?.pushViewController(homeVc, animated: false)
    }
    

    func displayIconOnLeftTextFieldView( _ systemName: String, _ textField: UITextField){
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(systemName: systemName)
        imageIcon.tintColor = .lightGray
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: systemName)!.size.width, height: UIImage(systemName: systemName)!.size.height)
        imageIcon.frame = CGRect(x: 5, y: 0, width: UIImage(systemName: systemName)!.size.width, height: UIImage(systemName: systemName)!.size.height)
        
        textField.leftView = contentView
        textField.leftViewMode = .always
    }
    
    
    func displayPasswordToggleIcon(){
        let eyeIcon = UIImageView()
        eyeIcon.image = UIImage(systemName: "eye.slash")
        eyeIcon.tintColor = .lightGray
        let eyeContentView = UIView()
        eyeContentView.addSubview(eyeIcon)
        
        eyeContentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        
        eyeIcon.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        
        passwordTextFiled.rightView = eyeContentView
        passwordTextFiled.rightViewMode = .always
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility(tapGestureRecognizer:)))

        eyeIcon.isUserInteractionEnabled = true
        eyeIcon.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
    }
    
    //Tap Eye Icon to view Password
    @objc func togglePasswordVisibility(tapGestureRecognizer:UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if eyeClick
        {
            eyeClick = false
            tappedImage.image = UIImage(systemName: "eye.slash")
            passwordTextFiled.isSecureTextEntry = true
        }
        else{
            eyeClick = true
            tappedImage.image = UIImage(systemName: "eye")
            passwordTextFiled.isSecureTextEntry = false
            
        }
    }
    
   
}
