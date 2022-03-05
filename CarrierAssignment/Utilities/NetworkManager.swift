//
//  NetworkManager.swift
//  Gangireddi
//
//  Created by Apple on 30/01/22.
//

import UIKit

class NetworkManager {
    
    static let baseUrl = "https://seanallen-course-backend.herokuapp.com/"
    private let appetizerURL = baseUrl + "swiftui-fundamentals/appetizers"
    
    func getAppetizers(complitionHandler: @escaping (Result<[Appetizer],APIError>)->Void) {
        
        guard let url = URL(string: appetizerURL) else {
            complitionHandler(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                complitionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complitionHandler(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                complitionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeResponse = try decoder.decode(AppetizerResponse.self, from: data)
                complitionHandler(.success(decodeResponse.request))
                
            } catch {
                complitionHandler(.failure(.invalidData))
            }
            
            
        }
        task.resume()
       
    }

}
