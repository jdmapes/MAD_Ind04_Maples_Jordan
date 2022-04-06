//
//  StateViewModel.swift
//  MAD_Ind04_Maples_Jordan
//
//  Created by Jordan Maples on 4/4/22.
//

import Foundation

//class StateViewModel {
//    
//    private var apiService = ApiService()
//    private var statesListInfo = [States]()
//    
//    func fetchgetStateinfo(completion: @escaping () -> ()) {
//        apiService.getStateInfo { (result) in
//            switch result {
//            case .success(let listOf):
//                self.statesListInfo = listOf.states
//                completion()
//            case .failure(let error):
//                print("JSON data parsing error: \(error)")
//            }
//        }
//    }
//    
//    func numberOfRowsInSection(section: Int) -> Int {
//        if statesListInfo.count != 0 {
//            return statesListInfo.count
//        }
//        return 0
//    }
//    
//    func cellForRowAt (indexPath: IndexPath) -> States {
//        return statesListInfo[indexPath.row]
//    }
//}
