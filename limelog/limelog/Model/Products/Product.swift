//
//  File.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 10/25/21.
//

import Foundation

struct Product{
    
    let title: String
    let upc: String
    let description: String
    let urlImage: String
    let calories: Int
    let size: String
    let price: Double
    
    
    init?(title: String, upc: String, description: String, urlImage: String, calories: Int, size: String, price: Double ){
        self.title = title
        self.upc = upc
        self.description = description
        self.urlImage = urlImage
        self.calories = calories
        self.size =  size
        self.price = price
    }
    
}

struct category{
    let categoryTitle: String
    let categoryImageUrl: String
    let products: [Product]
    
    init?(categoryTitle: String, categoryImageUrl: String, products: [Product]){
        self.categoryTitle = categoryTitle
        self.categoryImageUrl = categoryImageUrl
        self.products = products
    }
}

struct ProductCategory{
    let categorySectionTitle: String
    let categoriesList: [category]
    
    init(categorySectionTitle: String, categoriesList: [category]){
        self.categorySectionTitle = categorySectionTitle
        self.categoriesList = categoriesList
    }
    
    

    
}

struct productsListByCategory{
    
    let categoryTitle: String
    let products: [Product]
       
    init(categoryTitle: String, products: [Product]){
        self.categoryTitle = categoryTitle
        self.products = products
    }
        
    }
