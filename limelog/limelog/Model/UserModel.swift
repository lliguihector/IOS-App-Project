//
//  UserModel.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/15/21.
//

import Foundation

//User Data Model initialise with decoded mongoDB response body JSON
struct UserModel{
    
    let userId: String
    let name: String
    let email: String 
    let password: String
    let date: String
   
    
    
    
    //COMPUTED PROPERTY
    var firstName: String{
        
        let fullNameArray = name.components(separatedBy: " ")
        let firstName = fullNameArray[0] //First
        
        return firstName
    }
    
    var lastName: String{
        
        let fullNameArray = name.components(separatedBy: " ")
        let lastName = fullNameArray[1]//Last
        
        return lastName
    }
    
    
    var initilas: String{
            let fullNameArray = name.components(separatedBy: " ")
            
            let firstName = fullNameArray[0] //First
            let lastName = fullNameArray[1]//Last
            
            let firstNameInitial = Array(firstName)
            let lastNameInitial = Array(lastName)
            
            let initilas = "\(firstNameInitial[0])\(lastNameInitial[0])"
            
            return initilas
        }
    
    //Initializer
    init?(userId: String, name: String, email: String,password: String, date: String){
        
        
        self.userId = userId
        self.name = name
        self.email = email
        self.password = password
        self.date = date
    }
}
