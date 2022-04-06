//
//  TableViewController.swift
//  MAD_Ind04_Maples_Jordan
//
//  Created by Jordan Maples on 4/4/22.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var tableViewController: UITableView!
    
    var stateView = StateViewModel()
    var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stateView.fetchgetStateinfo(completion: self.tableViewController.reloadData)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stateView.numberOfRowsInSection(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Table Cell", for: indexPath)

        // Grab data for the cell from the tuple
        let cellData = stateView.cellForRowAt(indexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = cellData.state
        cell.detailTextLabel?.text = cellData.nickname

        return cell
    }
 
}
// Assigning the values from the JSON
struct StatesResult: Decodable {
    let states: [States]
    
    private enum Keys: String, CodingKey {
        case states = "states"
    }
}

struct States: Decodable {
    let state: String?
    let nickname: String?
    
    private enum Keys: String, CodingKey {
        case state = "state"
        case nickname = "nickname"
    }
}

//API Call to parse the JSON structure
class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getStateInfo(completion: @escaping (Result<StatesResult, Error>) -> Void) {
        
        let statesInfoURL = "https://webmail.cs.okstate.edu/~mjordan/statescript.php"
        
        guard let url = URL(string: statesInfoURL) else {return}
        
        // Creating the URL Session
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Error handling and output message
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
            // Print Response code looking for 200 which is valid
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

//Assigning the API return and verifying that stateinfoList returns 50 key:value pairs
class StateViewModel {
    
    private var apiService = ApiService()
    private var statesListInfo = [States]()
    
    // Returning a list of states from the parse if successful
    func fetchgetStateinfo(completion: @escaping () -> ()) {
        apiService.getStateInfo { (result) in
            switch result {
            case .success(let listOf):
                self.statesListInfo = listOf.states
                completion()
            case .failure(let error):
                print("JSON data parsing error: \(error)")
            }
        }
    }
    
    // Setting Num of rows based on states list return count
    func numberOfRowsInSection(section: Int) -> Int {
        if statesListInfo.count != 0 {
            return statesListInfo.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> States {
        return statesListInfo[indexPath.row]
    }
}

//Comment to Add pdf and sources


