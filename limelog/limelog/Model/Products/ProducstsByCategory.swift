//
//  ProducstsByCategory.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/5/21.
//

import Foundation


class ProductsByCategory{
    
    let category: String
    let items: [ProductsDataModel]
    var isOpen: Bool = false
    
    init(category: String, items:[ProductsDataModel],isOpen: Bool = false){
        self.category = category
        self.items = items
        self.isOpen = isOpen
    }
}
