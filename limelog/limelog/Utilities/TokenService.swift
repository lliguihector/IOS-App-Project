//
//  TokenService.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 7/11/21.
//

import UIKit

class TokenService{
    static let tokenInstance = TokenService()
    let defaults = UserDefaults.standard
    
    func saveToke(_ token: String){
        defaults.setValue(token, forKey: constant.token)
    }
    
    
    
    func saveUserID(_ userID: String){
        defaults.setValue(userID, forKey: constant.userID)
    }
    
    
    func getUserID() -> String{
        
        if let token = defaults.object(forKey: constant.userID) as? String{
        return token
        }else{
            return ""
        }
        
    }
    
    
    func getToken() -> String{
        if let token = defaults.object(forKey: constant.token) as? String{
        return token
        }else{
            return ""
        }
    }
    
    
    
    func checkForLogin() -> Bool{
        
        if getToken() == ""{
            return false
        }else {
            return true
        }
    }
    
    
    
    func removeToken(){
        defaults.removeObject(forKey: constant.token)
       
    }
    
    
    func removeUserID(){
        defaults.removeObject(forKey: constant.userID)
 
    }
    
    
}
