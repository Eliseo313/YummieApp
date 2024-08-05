//
//  Route.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 16/07/24.
//

import Foundation

enum Route {
    static let baseUrl = "http://192.168.100.65:8888/Yummie/index.php"
    
    case fetchAll
    case fetchAllCategories
    case placeOrder(Int)
    case fetchCategoryDishes(Int)
    case fetchOrders
    
    var description : String{
        switch self{
        case .fetchAllCategories: 
            return "/categorias"
        case .placeOrder(let dishId):
            return "/orders/\(dishId)"
        case .fetchCategoryDishes(let categoryId):
            return "/dishes/\(categoryId)"
        case .fetchOrders:
            return "/orders"
        case .fetchAll:
            return "/all-dishes"
        }
    }
    
}
