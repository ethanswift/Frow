//
//  NetworkManager.swift
//  Frow
//
//  Created by ehsan sat on 6/29/21.
//  Copyright © 2021 ehsan sat. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> ()
typealias ErrorHandler = (String) -> ()

class NetworkManager {
    
    static let genericError = "Network reachiblity error"
    func requestLogin(url: URL,
                    successHandler: @escaping (Data) -> Void,
                    errorHandler: @escaping ErrorHandler)
    {
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(NetworkManager.genericError)
                return
            }
            
            if !self.isSucess(urlResponse: urlResponse!) {
                guard let data = data else {
                    print(error?.localizedDescription)
                    errorHandler(NetworkManager.genericError)
                    return
                }
                successHandler(data)
            }  
        }
        
        let parameters = ["grant_type": "client_credentials",
                          "client_id" : "21525f50179f41b191563b0c8a4d75d2",
                          "client_secret" : "d7719a929b44482e83461680beca7208"]
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        let body = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    func isSucess (successCode: Int) -> Bool {
        return (successCode >= 200 && successCode < 300)
    }
    
    func isSucess (urlResponse: URLResponse) -> Bool {
        guard let response = urlResponse as? HTTPURLResponse else {return false}
        return isSucess(successCode: response.statusCode)
    }
    
    func getDataFromAPI(url: URL,
                        token: String,
                        successHandler: @escaping (Data) -> Void,
                        errorHandler: @escaping ErrorHandler)
        {
            let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
                if let error = error {
                    print(error.localizedDescription)
                    errorHandler(NetworkManager.genericError)
                    return
                }
                
                if !self.isSucess(urlResponse: urlResponse!) {
                    guard let data = data else {
                        print(error?.localizedDescription)
                        errorHandler(NetworkManager.genericError)
                        return
                    }
                    successHandler(data)
//                    if let responseObject = try? JSONDecoder().decode(Data.self, from: data) {
//                        print(responseObject)
//                        print("***")
//                        successHandler(responseObject)
//                        return
//                    }
                }
//                print(data?.base64EncodedString())
                
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        }
}
