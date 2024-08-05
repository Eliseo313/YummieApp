//
//  NetworkService.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 16/07/24.
//

import Foundation
struct NetworkService{
    
    static let shared = NetworkService()
    
    private init (){}
    
    func fetchAllCategories(completion: @escaping(Result<AllDishes,Error>) -> Void){
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    func fetchAll(completion: @escaping(Result<AllDishes,Error>) -> Void){
        request(route: .fetchAll, method: .get, completion: completion)
    }
    
    func placeOrder(dishId: Int, name: String, completion:@escaping(Result<Order,Error>) -> Void){
         
        let params = ["name": name]
        
        request(route: .placeOrder(dishId), method: .post,parameters: params ,completion: completion)
    }
    
    func fetchCategoryDishes(categoryId: Int, completion: @escaping(Result<[Dish], Error>) -> Void) {
            request(route: .fetchCategoryDishes(categoryId), method: .get, completion: completion)
        }
    
    func fetchOrders(completion:@escaping(Result<[Order],Error>)->Void){
        request(route: .fetchOrders, method: .get, completion: completion)
    }
    
    private func request<T: Decodable>(
        route: Route,
        method: Method,
        parameters: [String:Any]? = nil,
        completion: @escaping(Result<T,Error>)
        -> Void ){
        
            guard let request = createRequest(route: route, method: method, parameters: parameters) else {
                
                completion(.failure(AppError.unknownError))
                return
            }
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                var result: Result<Data,Error>?
                if let data = data {
                    result = .success(data)
                    
//                    let responseString = String(data: data, encoding: .utf8) ?? "no se pudo hacer stringify a data"
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                       let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("Response JSON:\n\(jsonString)")
                    } else {
                        print("Error al formatear la respuesta JSON")
                    }
//                    print("Response JSON: \n\(responseString)")
                }else if let error = error{
                    result = .failure(error)
                    print("el error es:\n \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    self.handleResponse(result: result, completion: completion)
                }
                
            }.resume()
    }
    
    private func handleResponseDeprecated<T: Decodable>(result: Result<Data,Error>?,
                                              completion: (Result<T,Error>)->Void){
        
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            }else {
                completion(.failure(AppError.unknownError))
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }

        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ApiResponse<T>.self, from: data)
                if let error = response.error {
                    completion(.failure(AppError.serverError(error)))
                } else if let decodedData = response.data {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(AppError.unknownError))
                }
            } catch {
                completion(.failure(AppError.errorDecoding))
            }

        case .failure(let error):
            completion(.failure(error))
        }
    }

    /// Función que ayuda a generar una urlRequest
    /// - Parameters:
    ///   - route: ruta a los recursos en el backend
    ///   - method: tipo de solicitud: get,post,etc...
    ///   - parameters: cualquiero información extra que necesites enviar al backend
    /// - Returns: URLRequest
     private func createRequest (route: Route, method: Method,parameters: [String: Any]? = nil) -> URLRequest? {
        
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method{
                
            case .get:
                var urlComponet = URLComponents(string: urlString)
                urlComponet?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")
                }
                urlRequest.url = urlComponet?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            
            }
        }
        return urlRequest
        
    }
}
