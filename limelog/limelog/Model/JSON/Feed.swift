//
//  FeedData.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/1/21.
//

import Foundation


struct Feed: Codable{
    let _id: String
    let storeName: String
    let storeImageURL: String
    let title: String
    let description: String
    let imageURL: String
    let date: String 

}


struct Feeds: Codable{
    
    let Feeds: [Feed]
}
