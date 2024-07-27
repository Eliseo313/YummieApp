//
//  AllDishes.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 22/07/24.
//

import Foundation

struct AllDishes: Decodable{
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
