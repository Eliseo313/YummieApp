//
//  DishCategory.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 07/07/24.
//

import Foundation

struct DishCategory: Decodable {
    let id,name,image: String?
    
    enum CodingKeys: String,CodingKey {
        case id
        case name = "title"
        case image
    }
}
