//
//  personalInfoModel.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 7/13/21.
//

import Foundation

class PersonalInfoModel{
    
    let firstName: String
    let lastName: String
    let userIdRef: String
    
    
    
    init?(firstName: String, lastName: String, userIdRef: String)
    {
        
        self.firstName = firstName
        self.lastName = lastName
        self.userIdRef = userIdRef
    }
   
    
}
