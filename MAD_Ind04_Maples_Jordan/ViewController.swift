//
//  ViewController.swift
//  MAD_Ind04_Maples_Jordan
//
//  Created by Jordan Maples on 4/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    var stateView = StateViewModel()
    var apiService = ApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        apiService.getStateInfo { (result) in
            print(result)
        }
    }
    
    // MARK: - Table view data source

    
    

}

