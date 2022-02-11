//
//  LogoutView.swift
//  Album
//
//  Created by Ophélie Rochefeuille on 09/02/2022.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack{
            Button("Log out", action: {
                model.logout()
            })
        }
        .padding()
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
