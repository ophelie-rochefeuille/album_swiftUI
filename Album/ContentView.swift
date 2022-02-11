//
//  ContentView.swift
//  Album
//
//  Created by Ophélie Rochefeuille on 09/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = ViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            LogoutView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }.environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
