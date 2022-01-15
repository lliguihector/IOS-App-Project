//
//  LogInData.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/18/21.
//

import Foundation

//Struct used to encode or decode JSON responce from API
struct LoginData: Codable {
    
    let email: String
    let password: String
    
    //Initialize upon creating a new instance
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
}
