import UIKit

class NetworkManager {
    
    func callLoginAPI(userName: String, password: String, complitionHandler: @escaping (Result<AuthModel,APIError>)->Void) {
        
        let urlString = BASE_URL + LOGIN_API
        
        guard let url = URL(string: urlString) else {
            complitionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(CONTENT_TYPE_VALUE, forHTTPHeaderField: CONTENT_TYPE)
        request.httpMethod = HTTP_METHOD_POST
        let requestBody = String(format: "{\"email\": \"%@\",\"password\": \"%@\"}",userName, password)
    
        request.httpBody = requestBody.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let filePath = Bundle.main.url(forResource: "LoginResponse", withExtension: "json")?.path {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                    let decoder = JSONDecoder()
                    let decodedResponse: AuthModel = try decoder.decode(AuthModel.self, from: data)
                    complitionHandler(.success(decodedResponse))
                }
                catch {
                    print(error.localizedDescription)
                }
                return
            }
            
            if let _ = error {
                complitionHandler(.failure(.unableToComplete))
                return
            }
                
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complitionHandler(.failure(.invalidResponse))
                return
            }
                
            guard let responseData: Data = data else {
                complitionHandler(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse: AuthModel = try decoder.decode(AuthModel.self, from: responseData)
                complitionHandler(.success(decodedResponse))
                
            } catch {
                complitionHandler(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func callDeviceDetailsAPI(complitionHandler: @escaping (Result<[XDeviceModel],APIError>)->Void) {
        
        let urlString = BASE_URL + X_DEVICE_API
        
        guard let url = URL(string: urlString) else {
            complitionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(CONTENT_TYPE_VALUE, forHTTPHeaderField: CONTENT_TYPE)
        request.httpMethod = HTTP_METHOD_GET
    
        request.setValue(CarrierAssignment_SharedInstance.autorizatioToken, forHTTPHeaderField: AUTHORIZATION)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let filePath = Bundle.main.url(forResource: "XDeviceData", withExtension: "json")?.path {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode([XDeviceModel].self, from: data)
                    complitionHandler(.success(decodedResponse))
                }
                catch {
                    print(error.localizedDescription)
                }
                return
            }
            
            if let _ = error {
                complitionHandler(.failure(.unableToComplete))
                return
            }
                
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complitionHandler(.failure(.invalidResponse))
                return
            }
                
            guard let responseData: Data = data else {
                complitionHandler(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse: [XDeviceModel] = try decoder.decode([XDeviceModel].self, from: responseData)
                complitionHandler(.success(decodedResponse))
                
            } catch {
                complitionHandler(.failure(.invalidData))
            }
            
        }
        task.resume()
    }

}
