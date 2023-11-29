//
//  KeyChainPropertyWrapper.swift
//  PasswordApp
//
//  Created by Alec Morrison on 7/24/23.
//

import SwiftUI


// Custom Wrapper
@propertyWrapper
struct KeyChain: DynamicProperty {
    @State var data: Data?
    
    var wrappedValue: Data?{
        get{KeyChainHelper.standard.read(key: key, account: account)}
        nonmutating set{
            
            guard let newData = newValue else{
                data = nil
                KeyChainHelper.standard.delete(key: key, account: account)
                return
            }
            
            // Updating or Setting keychain value
            KeyChainHelper.standard.save(data: newData, key: key, account: account)
            
            //Update Value
            data = newValue
        }
    }
    
    
    var key: String
    var account: String
    
    init(key: String, account: String){
        self.key = key
        self.account = account
        
        //setting initial state
        
        _data = State(wrappedValue: KeyChainHelper.standard.read(key: key, account: account))
    }
}


