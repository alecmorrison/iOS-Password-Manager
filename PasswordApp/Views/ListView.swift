
//  ListView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 9/10/23.


import SwiftUI


//MARK:- Contacts
struct Contact : Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var telephone: String
}


//MARK:- Search Bar
struct SearchBar : View {
    @Binding var searchTerm : String
    @State var showCancelButton = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("search", text: self.$searchTerm, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                }).foregroundColor(.primary)

                Button(action: {
                    self.searchTerm = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(self.searchTerm == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if self.showCancelButton {
                Button("Cancel") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.searchTerm = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
    }
}

struct ListView: View {
    @StateObject var contactsModel = ContactsModel()
    @State var searchTerm = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchTerm: $searchTerm)
                List {
                    ForEach(contactsModel.sectionDictionary.keys.sorted(), id:\.self) { key in
                        if let contacts = contactsModel.sectionDictionary[key]?.filter({ (contact) -> Bool in
                            self.searchTerm.isEmpty ? true :
                                "\(contact)".lowercased().contains(self.searchTerm.lowercased())
                        }), !contacts.isEmpty {
                            Section(header: Text("\(key)")) {
                                ForEach(contacts){ value in
                                    Text("\(value.firstName) \(value.lastName)")
                                }
                            }
                        }
//                        {
//                            Section(header: Text("\(key)")) {
//                                ForEach(contacts){ value in
//                                    Text("\(value.firstName) \(value.lastName)")
//                                }
//                            }
//                        }
                    }
                }.listStyle(GroupedListStyle())
            }.navigationTitle("Contacts")
        }
        
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


//import SwiftUI
//
//struct Contact: Identifiable, Comparable {
//    static func < (lhs: Contact, rhs: Contact) -> Bool {
//        return (lhs.lastName, lhs.firstName) < (rhs.lastName, rhs.firstName)
//    }
//
//    var id = UUID()
//    let firstName: String
//    let lastName: String
//}
//
//let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]
//
//struct Contacts: View {
//    @State var searchText: String = ""
//
//    var contacts = [Contact]()
//
//    var body: some View {
//        VStack {
//            ScrollViewReader { scrollProxy in
//                ZStack {
//                    NavigationView{
//                        List {
//                            ForEach(alphabet, id: \.self) { letter in
//                                Section(header: Text(letter).id(letter)) {
//                                    ForEach(contacts.filter({ (contact) -> Bool in
//                                        contact.firstName.prefix(1).uppercased() == letter
//                                    })) { contact in
//                                        HStack {
//                                            Text(contact.firstName)
//                                            Text(contact.lastName)
//                                        }
//                                    }
//                                }
//                            }
//                            Spacer()
//                            HStack{
//                                Spacer()
//                                Text("Total Contacts")
//                                    .multilineTextAlignment(.center)
//                                Spacer()
//                            }
//                            .listRowSeparator(.hidden)
//                        }
//                        .navigationTitle("Contacts")
//                        .listStyle(PlainListStyle())
//                    }
//                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
//                    //.padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
//
//
//                    VStack {
//                        ForEach(alphabet, id: \.self) { letter in
//                            //HStack {
//                                //Spacer()
//                                Button(action: {
//                                    print("letter = \(letter)")
//                                    //need to figure out if there is a name in this section before I allow scrollto or it will crash
//                                    if contacts.first(where: { $0.lastName.prefix(1) == letter }) != nil {
//                                        withAnimation {
//                                            scrollProxy.scrollTo(letter, anchor: .top)
//                                        }
//                                    }
//                                }, label: {
//                                    Text(letter)
//                                        .font(.system(size: 12))
//                                        .padding(.trailing, 7)
//                                })
//                            //}
//                                .padding(.leading,375)
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    init() {
//        contacts.append(Contact(firstName: "Chris", lastName: "Ryan"))
//        contacts.append(Contact(firstName: "Allyson", lastName: "Ryan"))
//        contacts.append(Contact(firstName: "Jonathan", lastName: "Ryan"))
//        contacts.append(Contact(firstName: "Brendan", lastName: "Ryaan"))
//        contacts.append(Contact(firstName: "Jaxon", lastName: "Riner"))
//        contacts.append(Contact(firstName: "Leif", lastName: "Adams"))
//        contacts.append(Contact(firstName: "Frank", lastName: "Conors"))
//        contacts.append(Contact(firstName: "allyssa", lastName: "Bishop"))
//        contacts.append(Contact(firstName: "Justin", lastName: "Bishop"))
//        contacts.append(Contact(firstName: "Johnny", lastName: "Appleseed"))
//        contacts.append(Contact(firstName: "George", lastName: "Washingotn"))
//        contacts.append(Contact(firstName: "Abraham", lastName: "Lincoln"))
//        contacts.append(Contact(firstName: "Steve", lastName: "Jobs"))
//        contacts.append(Contact(firstName: "Steve", lastName: "Woz"))
//        contacts.append(Contact(firstName: "Bill", lastName: "Gates"))
//        contacts.append(Contact(firstName: "Donald", lastName: "Trump"))
//        contacts.append(Contact(firstName: "Darth", lastName: "Vader"))
//        contacts.append(Contact(firstName: "Clark", lastName: "Kent"))
//        contacts.append(Contact(firstName: "Bruce", lastName: "Wayne"))
//        contacts.append(Contact(firstName: "John", lastName: "Doe"))
//        contacts.append(Contact(firstName: "Jane", lastName: "Doe"))
//        contacts.append(Contact(firstName: "Zach", lastName: "Doe"))
//        contacts.append(Contact(firstName: "Zach", lastName: "Doe"))
//        contacts.append(Contact(firstName: "Zach", lastName: "Doe"))
//        contacts.append(Contact(firstName: "Zach", lastName: "Doe"))
//        contacts.sort()
//    }
//}
//
//struct Contacts_Previews: PreviewProvider {
//    static var previews: some View {
//        Contacts()
//    }
//}
//
//
