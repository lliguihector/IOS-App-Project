//
//  FeedModel.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/1/21.
//

import Foundation


struct FeedModel{
    let title: String
    let description: String
    let imageURL: String
    let date: String

    
    
    
    
    //Initializer
    init?(title: String, description: String, imageURL: String, date: String){
        
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.date = date
    }
    
    
}
