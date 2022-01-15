//
//  Validation.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/30/21.
//

import Foundation
class Validation{
    
    
    public func validateName(name: String) -> Bool{
        
        let nameRegex = "\\w{3,18}$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        
        
        return isValidateName
    }
    
    
    public func validateEmail(email: String) -> Bool{
        
        let emailRegEx =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = email.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format: "SELF MATCHES %@",emailRegEx)
        let isValidatedEmail = validateEmail.evaluate(with: trimmedString)
        
       
        return isValidatedEmail
    }
    
    
    public func validatePassword(password: String) -> Bool{
       //Minimum 6 characters at least 1 Alpabet and 1 Number
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,32}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassword = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassword.evaluate(with: trimmedString)

     return isvalidatePass
    }
    
    //Trim any empty Spaces
    public func trimWhiteSpaces(str: String) -> String{
        
        let trimmedStr = str.trimmingCharacters(in: .whitespacesAndNewlines)
    
        
        return trimmedStr
        
    }
    
    
    
}
