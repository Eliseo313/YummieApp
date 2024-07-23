//
//  Dish.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 10/07/24.
//

import Foundation

struct Dish: Decodable{
    let id,name, description,image: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories ?? 0) calorias"
    }
}
