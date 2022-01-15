//
//  Constants.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/17/21.
//
import UIKit
struct constant{
    //API URL Endpoints
    static let usersUrl = URL(string: "http://localhost:3000/user")
    static let getUserByID = URL(string: "http://localhost:3000/user/")
    static let registerNewUser = URL(string: "http://localhost:3000/api/user/register")
    
    static let getUserInfoByID = URL(string:"")
    
    static let newsFeedUrl = URL(string: "http://localhost:3000/feed")
    static let plulistUrl = URL(string: "http://localhost:3000/plu")
    

    //User defaults
    static let token = "jsonwebtoken"
    static let userID = "userID"
    static let islogin = "state"

    //View Controller ID
    static let loginViewController = "LoginVC"
    static let homeViewController = "HomeVC"
    
    
    
    //Segue ID
    static let registerToHomeSegue = "RegisterToHomeScreen"
    static let loginToHomeSegue = "LoginToHomeScreen"
    

   static let loginScreen =  "HomeToLogInScreen"
    
   static let loadingViewTag = 1234
    
    static let cellIdentifier = "Cell"
    
    
    
    
    
}
