//
//  Data.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/11/21.
//

import Foundation


//This Structure is used to decode or encode JASON data from API
struct UserData: Codable {
    let _id: String
    let name: String
    let email: String
    let password: String
    let date: String
}

struct Users: Codable {
    
    let Users: [UserData]
    
}
