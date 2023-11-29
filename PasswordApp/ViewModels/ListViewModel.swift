
//  ListViewModel.swift
//  PasswordApp
//
//  Created by Alec Morrison on 9/10/23.


import Foundation

class ContactsModel : ObservableObject {
    //MARK:- Variables
    var contactData : [Contact]
    @Published var sectionDictionary : Dictionary<String , [Contact]>
    //MARK:- initializer
    init() {
        contactData = [Contact(firstName: "Jacob", lastName: "Smith", telephone: ""),
                       Contact(firstName: "alexandra", lastName: "Johnson", telephone: ""),
                       Contact(firstName: "daniel", lastName: "Williams", telephone: ""),
                       Contact(firstName: "Angel", lastName: "Brown", telephone: ""),
                       Contact(firstName: "David", lastName: "Jones", telephone: ""),
                       Contact(firstName: "Michael", lastName: "Miller", telephone: ""),
                       Contact(firstName: "Jose", lastName: "Garcia", telephone: ""),
                       Contact(firstName: "Joseph", lastName: "Davis", telephone: ""),
                       Contact(firstName: "christopher", lastName: "Martin", telephone: ""),
                       Contact(firstName: "Gabriel", lastName: "Wilson", telephone: ""),
                       Contact(firstName: "Anthony", lastName: "Brown", telephone: "")]
        sectionDictionary = [:]
        sectionDictionary = getSectionedDictionary()
    }


    //MARK:- sectioned dictionary
    func getSectionedDictionary() -> Dictionary <String , [Contact]> {
        let sectionDictionary: Dictionary<String, [Contact]> = {
            return Dictionary(grouping: contactData, by: {
                let name = $0.firstName
                let normalizedName = name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                let firstChar = String(normalizedName.first!).uppercased()
                return firstChar
            })
        }()
        return sectionDictionary
    }
}


