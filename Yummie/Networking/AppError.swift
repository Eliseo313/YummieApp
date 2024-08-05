//
//  AppError.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 18/07/24.
//

import Foundation

enum AppError: LocalizedError{
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String?{
        switch self {
            
        case .errorDecoding:
            return "El  Response no se pudo decodear"
        case .unknownError:
            return "Bruhhh!! no tengo idea que paso"
        case .invalidUrl:
            return "La url no es válida"
        case .serverError(let error):
            return error
        }
    }
}
