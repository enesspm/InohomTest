//
//  LoginResponse.swift
//  InohomTest
//
//  Created by Enes Pamukçu on 6.12.2025.
//

import Foundation

struct LoginResponse: Codable {
    let id: Int
    let params: [String]
    let method: String
    let error: String
    let isRequest: Bool
    
//    {"id":792,"params":["demo"],"method":"OnAuthenticated","error":null,"is_request":true}
}
