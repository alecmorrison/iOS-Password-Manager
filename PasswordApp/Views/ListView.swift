import SwiftUI
import FirebaseFirestoreSwift

let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2", "3", "4", "5", "6", "7", "8", "9"]


struct ListView: View {
    @StateObject var viewModel: ListViewModel
    @FirestoreQuery var passwords: [PasswordItem]
    
    @State private var selectedPassword: PasswordItem
    
    init(userId: String){
        //users/<id>/passwords/<entries>
        self._passwords = FirestoreQuery(collectionPath: "users/\(userId)/passwords")
        self._viewModel = StateObject(wrappedValue: ListViewModel(userId: userId))
        self.selectedPassword = .init(id: "",
                                  title: "",
                                  usernameEmail: "",
                                  password: "")
        var sortedPasswords: [PasswordItem]{
            return passwords.sorted()
        }
    }
    
    
    
    
    @State var searchText: String = ""
    
    
    var filteredPasswords: [PasswordItem] {
        guard !searchText.isEmpty else { return passwords.sorted() }
        return passwords.filter { $0.title.localizedStandardContains(searchText) }.sorted()
    }
        
    var body: some View {
        VStack {
            ScrollViewReader { scrollProxy in
                ZStack {
                    NavigationStack{
                        List {
                            ForEach(alphabet, id: \.self) { letter in
                                Section(header: Text(letter).id(letter)) {
                                    ForEach(filteredPasswords.filter({ (password) -> Bool in
                                        password.title.prefix(1).uppercased() == letter
                                    })) { password in
                                        Button{
                                            selectedPassword = password
                                            viewModel.showingInfoView = true
                                        }label:{
                                            Text(password.title)
                                        }
                                        .swipeActions{
                                            Button{
                                                // Delete
                                                viewModel.delete(id: password.id)
                                            }label: {
                                                Text("Delete")
                                            }
                                            .tint(.red)
                                            Button{
                                                // EDIT
                                                selectedPassword = password
                                                viewModel.showingEditPasswordView = true
                                                
                                            } label: {
                                                Text("Edit")
                                            }
                                            .tint(.gray)
                                        }
                                        .sheet(isPresented: $viewModel.showingEditPasswordView){
                                            EditPasswordView(newPasswordPresented: $viewModel.showingEditPasswordView, password: selectedPassword)
                                        }
                                        .sheet(isPresented: $viewModel.showingInfoView){
                                            InfoView(infoPresented: $viewModel.showingInfoView, password: selectedPassword)
                                        }
                                    }
                                }
                            }
                            
                            
                
//                            Section(header: Text("#")) {
//                                ForEach(filteredPasswords.filter({ (password) -> Bool in
//                                    !password.title.prefix(1).isletter()
//                                })) { password in
//                                    Button{
//                                        selectedPassword = password
//                                        viewModel.showingInfoView = true
//                                    }label:{
//                                        Text(password.title)
//                                    }
//                                    .swipeActions{
//                                        Button{
//                                            // Delete
//                                            viewModel.delete(id: password.id)
//                                        }label: {
//                                            Text("Delete")
//                                        }
//                                        .tint(.red)
//                                        Button{
//                                            // EDIT
//                                            selectedPassword = password
//                                            viewModel.showingEditPasswordView = true
//                                            
//                                        } label: {
//                                            Text("Edit")
//                                        }
//                                        .tint(.gray)
//                                    }
//                                    .sheet(isPresented: $viewModel.showingEditPasswordView){
//                                        EditPasswordView(newPasswordPresented: $viewModel.showingEditPasswordView, password: selectedPassword)
//                                    }
//                                    .sheet(isPresented: $viewModel.showingInfoView){
//                                        InfoView(infoPresented: $viewModel.showingInfoView, password: selectedPassword)
//                                    }
//                                }
//                            }
                                
                            
                            
                            
                            
                            
                            Spacer()
                            HStack{
                                Spacer()
                                Text("Total Passwords")
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .listRowSeparator(.hidden)
                        }
                        
                        .navigationTitle("Passwords")
                        .toolbar {
                            Button{
                                viewModel.showingNewPasswordView = true
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")

                    
                    
                    // Alphabet scroll bar on right
                    VStack {
                        ForEach(alphabet, id: \.self) { letter in
                            HStack {
                                Button(action: {
                                    if passwords.first(where: { $0.title.prefix(1) == letter }) != nil {
                                        withAnimation {
                                            scrollProxy.scrollTo(letter, anchor: .top)
                                        }
                                    }
                                }, label: {
                                    Text(letter)
                                        .font(.system(size: 12))
                                        .padding(.trailing, 7)
                                })
                            }
                                .padding(.leading,375)
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingNewPasswordView) {
                NewPasswordView(newPasswordPresented: $viewModel.showingNewPasswordView)
            }
        }
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(userId: "GJTQrckPnLWNGhTZcZKV9Sc7sup2")
    }
}
