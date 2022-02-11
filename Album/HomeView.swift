//
//  HomeView.swift
//  Album
//
//  Created by Ophélie Rochefeuille on 09/02/2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

struct HomeView: View {
    @EnvironmentObject var model: ViewModel
    @State var detailsAreActives = false
    @State var showModalView = false
    @State private var items: [Concert] = []
    
    var body: some View {
        VStack{
            if let user = model.user{
                VStack {
                    Text("Voici les derniers concerts disponibles !").foregroundColor(.white)
                    NavigationView{
                        List{
                            ForEach(model.concerts, id: \.id) { concert in
                                
                                let name = concert.name ?? "No name"
                                let lieu = concert.Lieu ?? "No lieu"
                                let date = concert.Date ?? "No Date"
                                let description = concert.Description ?? "No description"
                                
                                NavigationLink(destination: ConcertView(concert: concert)){
                                    
                                    VStack{
                                        
                                        HStack {
                                            Image("chanteurs")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50.0, height: 50.0)
                                                .clipShape(Circle())
                                            Spacer()
                                            Text("\(name)")
                                        }
                                        
                                        HStack{
                                            Text("\(lieu) - \(date)")
                                                .position(x: 50)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .onDelete{ (indexSet) in
                            indexSet.forEach({ index in
                                let concert = model.concerts[index]
                                Firestore.firestore().collection("Concerts").document(concert.id ?? "").delete()
                                })
                                model.concerts.remove(atOffsets: indexSet)
                                print(indexSet)
                            }
                            
                        }.background(Image("background_1"))
                        .navigationBarItems(trailing: Button(action: {
                            showModalView.toggle()
                        }) {
                            Image(systemName: "plus")
                        })
                    }
                    
                }.background(Image("background_1"))
                Button(action: {
                    showModalView.toggle()
                }) {
                    Image(systemName: "plus")
                }.sheet(isPresented: $showModalView) {
                    ModalView(showModalView: $showModalView)
                }
            } else {
                LoginView()
            }
            
            if let errorMessage = model.errorMessage{
                Text(errorMessage)
                    .padding()
                    .foregroundColor(.red)
            }
        }.background(Image("background_1"))
    }

    private func addRow() {
        model.concerts.append(Concert())

       }
}

struct ModalView: View {
    
    @EnvironmentObject var model: ViewModel
    @Binding var showModalView: Bool
    
    @State var name = ""
    @State var lieu = ""
    @State var date = ""
    
    var body: some View {
        VStack {
           
            TextField("Nom de l'artiste", text:$name).padding()
            TextField("Lieu du concert", text:$lieu).padding()
            TextField("Heure du concert", text:$date).padding()
            
            HStack{
                Button("Ajouter", action: {model.addConcert(name: name, lieu: lieu, date: date)})
                Spacer()
                Button ("Done", action: {showModalView.toggle()})
            }.padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
