//
//  LoginRequestModel.swift
//  InohomTest
//
//  Created by Enes Pamukçu on 6.12.2025.
//

import Foundation

struct LoginRequestModel: Encodable{
    let isRequest: Bool
    let id: Int
    let params: [Param?]
    let method: String
    
    enum CodingKeys: String, CodingKey {
        case isRequest = "is_request"
        case id
        case params
        case method
    }
}

struct Param: Encodable {
    var userName: String? = nil
    var password: String? = nil
    var id: String? = nil
    var value: Int? = nil
}



//{"is_request":true,"id":8,"params":[{"username":"demo","password":"123456"}],"method":"Aut
//henticate"}
