//
//  ViewModel.swift
//  Album
//
//  Created by Ophélie Rochefeuille on 09/02/2022.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

@MainActor
class ViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var concerts = [Concert]()
    
    var listener: ListenerRegistration?
    var subscription: AnyCancellable?
    
    init() {
        subscription = $user.sink(receiveValue: { [weak self] user in
            self?.setListener(user: user)
        })
    }
}


// Firebase management
extension ViewModel {
    func login(mail: String, password: String) {
        // function to login
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: mail, password: password)
                errorMessage = .none
                user = authResult.user
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func logout() {
        //function to logout
        do {
            try Auth.auth().signOut()
            errorMessage = .none
            user = .none
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func snapshotListener(querySnapshot: QuerySnapshot?, error: Error?) {
        //function to recover data
        if let error = error {
            errorMessage = error.localizedDescription
        }
        
        if let documents = querySnapshot?.documents {
            print("Documents: \(documents)")
            do {
                concerts = try documents.compactMap({ document /* -> Concert? */ in
                    let concert = try document.data(as: Concert.self)
                    return concert
               })
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func setListener(user: User?) {
        if let existingListener = listener {
            existingListener.remove()
            print("Existing listener removed")
            listener = .none
            concerts = []
        }

        if let user = user {
            let collection = Firestore.firestore().collection("Concerts")
            listener = collection.addSnapshotListener { [weak self] (querySnapshot, error) in
                self?.snapshotListener(querySnapshot: querySnapshot, error: error)
            }
            print("Listener added for \(user.uid)")
        }
    }
    
    func deleteConcert(at offsets: IndexSet){
        // function to delete concert in database
        offsets.forEach({ index in
            let concert = concerts[index]
            Firestore.firestore().collection("Concerts").document(concert.id!).delete()
        })
        concerts.remove(atOffsets: offsets)
    }
    
    
    func addConcert(name: String, lieu: String, date: String){
        // function to add concert in database
        var ref: DocumentReference? 
        ref = Firestore.firestore().collection("Concerts").addDocument(data: [
            "name": name,
            "Lieu": lieu,
            "Date": date
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}

