//
//  ApiResponse.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 19/07/24.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
