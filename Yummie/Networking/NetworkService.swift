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
    
    func myFirstRequest(){
        request(route: .temp, method: .get, type: String.self, completion: {_ in})
    }
    
    private func request<T: Codable>(
        route: Route,
        method: Method,
        parameters: [String:Any]? = nil,
        type: T.Type,
        completion: (Result<T,Error>)
        -> Void ){
        
            guard let request = createRequest(route: route, method: method, parameters: parameters) else {
                
                completion(.failure(AppError.unknownError))
                return
            }
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                var result: Result<Data,Error>?
                if let data = data {
                    result = .success(data)
                    let responseString = String(data: data, encoding: .utf8) ?? "no se pudo hacer stringify a data"
                    
                    print("Response: \(responseString)")
                }else if let error = error{
                    result = .failure(error)
                    print("el error es:\n \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    //TODO decodear los resultados y enviarlos de vuelta al usuario
                }
                
            }.resume()
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
