//
//  KeyChainHelper.swift
//  PasswordApp
//
//  Created by Alec Morrison on 7/17/23.
//

import SwiftUI

// Key Chain Helper Class
class KeyChainHelper{
    // To Access class data
    static let standard = KeyChainHelper()
    
    // saving Key chain value
    func save(data: Data, key: String, account: String){
        //create query
        let query:  [CFString: Any] = [
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ]
        
        
        let cfQuery = query as CFDictionary
        // adding data to keychain
        let status = SecItemAdd(cfQuery, nil)
        
        // checking for status
        switch status{
            
            // success
        case errSecSuccess: print("Success")
            
            //updating data
        case errSecDuplicateItem:
            let updateQuery: [CFString: Any] = [
                kSecAttrAccount: account,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ]
            
            
            let cfUpdateQuery = updateQuery as CFDictionary
            // Update field
            let updateAttr = [kSecValueData: data] as CFDictionary
            SecItemUpdate(cfUpdateQuery, updateAttr)
        
        //otherwise error
        default: print("Error \(status)")
            
        }
    }
    
    // reading keychain Data
    func read(key: String, account: String)->Data? {
        let query: [CFString: Any] = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ]
        
        
        let cfQuery = query as CFDictionary
        //copy the data
        var resultData: AnyObject?
        SecItemCopyMatching(cfQuery, &resultData)
        
        return (resultData as? Data)
    }
    
    // deleting the key chain data
    func delete(key: String, account: String){
        let query: [CFString: Any] = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
        ]
        
        let cfQuery = query as CFDictionary
        
        SecItemDelete(cfQuery)
    }
    
}

