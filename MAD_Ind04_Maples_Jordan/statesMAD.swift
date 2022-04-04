//
//  statesMAD.swift
//  MAD_Ind04_Maples_Jordan
//
//  Created by Jordan Maples on 4/4/22.
//

import Foundation

struct StatesResult: Decodable {
    let states: [Result]
    
    private enum Keys: String, CodingKey {
        case states = "states"
    }
}

struct Result: Decodable {
    let state: String?
    let nickname: String?
    
    private enum Keys: String, CodingKey {
        case state = "states"
        case nickname = "nickname"
    }
}
