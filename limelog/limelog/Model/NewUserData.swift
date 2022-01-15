//
//  RegisterModel.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/24/21.
//

import Foundation

struct NewUserData: Codable{
    
    let name: String
    let email: String
    let password: String
    
    init(name: String, email: String, password: String){
        self.name = name
        self.email = email
        self.password = password
        
    }
}
