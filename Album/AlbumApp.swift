//
//  AlbumApp.swift
//  Album
//
//  Created by Ophélie Rochefeuille on 09/02/2022.
//

import SwiftUI
import Firebase

@main
struct AlbumApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
