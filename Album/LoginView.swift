//
//  LoginView.swift
//  Album
//
//  Created by Ophélie Rochefeuille on 09/02/2022.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var model: ViewModel
    @State var mail = ""
    @State var password = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Email").foregroundColor(.white)
            TextField("Email", text: $mail)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            Text("Password").foregroundColor(.white)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("S'identifier", action: {
                model.login(mail: mail, password: password)
            })
            .padding()
            .foregroundColor(.white)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

