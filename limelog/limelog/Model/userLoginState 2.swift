//
//  userLoginState.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 7/10/21.
//

import Foundation
struct userLoginState {
    
    let jwtToken: String
    let userID: String
    let loginState: Bool
    
    
    init?(jwtToken: String ,userID: String, loginState: Bool){
        
        self.jwtToken = jwtToken
        self.userID = userID
        self.loginState = loginState
        
    }
    
    
}
