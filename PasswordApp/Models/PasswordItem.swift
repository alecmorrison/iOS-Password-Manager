//
//  PasswordItem.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/22/24.
//

import Foundation

struct PasswordItem: Codable, Identifiable, Comparable {
    let id: String
    let title: String
    let usernameEmail: String
    let password: String
    
    static func < (lhs: PasswordItem, rhs: PasswordItem) -> Bool {
            return (lhs.title) < (rhs.title)
        }
    
    func asDictionary() -> [String: Any] {
            return [
                "id": id,
                "title": title,
                "usernameEmail": usernameEmail,
                "password": password
            ]
        }
    
}


