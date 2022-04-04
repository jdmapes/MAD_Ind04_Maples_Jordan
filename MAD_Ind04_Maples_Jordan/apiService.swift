//
//  apiService.swift
//  MAD_Ind04_Maples_Jordan
//
//  Created by Jordan Maples on 4/4/22.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getStateInfo(completion: @escaping (Result<StatesResult, Error>) -> Void) {
        
        let statesInfoURL = "https://webmail.cs.okstate.edu/~mjordan/statescript.php"
        
        guard let url = URL(string: statesInfoURL) else {return}
        
        // Creating the URL Session
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Error handling
            if let error = error {
                completion(.failure(error))
                print("Error in Datatask: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Empty Handling Response
                print("Empty Response")
                return
            }
            
            print("Response code: \(response.statusCode)")
            
            guard let data = data else {
                //Empty Data handling
                print("Data is Empty")
                
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(StatesResult.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
