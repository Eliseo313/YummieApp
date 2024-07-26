//
//  Route.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 16/07/24.
//

import Foundation

enum Route {
    static let baseUrl = "https://yummie.glitch.me/"
    
    case fetchAllCategories
    case placeOrder(String)
    
    var description : String{
        switch self{
        case .fetchAllCategories: return "/dish-categories"
        case .placeOrder(let dishId): return "/orders/\(dishId)"
        }
    }
    
}
