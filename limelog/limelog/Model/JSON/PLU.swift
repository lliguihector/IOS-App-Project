//
//  File.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 1/5/22.
//

import Foundation


struct PLU: Codable{
    let name: String
    let category: String
    let plucode: String
}

struct PluList: Codable{
    let PluList: [PLU]
}


