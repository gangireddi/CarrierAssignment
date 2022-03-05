//
//  UserModel.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import Foundation

struct AuthModel: Decodable {
    let success: String?
    let authorization_token: String?
    let user: User?
    
    enum CodingKey: String,Decodable {
        case success,authorization_token,user
    }
}

struct User: Decodable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let email: String?
    
    enum CodingKey: String,Decodable {
        case id,first_name,last_name,email
    }
}
