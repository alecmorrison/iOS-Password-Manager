//
//  User.swift
//  PasswordApp
//
//  Created by Alec Morrison on 8/14/23.
//

import Foundation

struct User: Codable{
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    
    func asDictionary() -> [String: Any] {
            return [
                "id": id,
                "name": name,
                "email": email,
                "joined": joined
            ]
        }
}

