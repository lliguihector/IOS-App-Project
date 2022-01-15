//
//  ProductsData.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/4/21.
//

import Foundation



struct ProductsDataModel{
    
    let name: String
    let category: String
    let description: String
    let imageUrl: String
    let price: Decimal
   
    
    init?(name: String, category: String, description: String, imageUrl: String, price: Decimal){
        self.name = name
        self.category = category
        self.description = description
        self.imageUrl = imageUrl
        self.price = price
    }
}

