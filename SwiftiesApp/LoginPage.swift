//
//  LoginPage.swift
//  SwiftiesApp
//
//  Created by Alumno on 08/10/24.
//

import SwiftUI

struct LoginPage: View {
    @State var username : String = ""
    @FocusState var usernameFieldFocused
    @State var password : String = ""
    
    @Binding var logged: Bool
    
    func validation(username: String, password: String){
        if (username == "admin" && password == "hi"){
            logged = true
        }
    }
    
    var body: some View {
        ZStack{
            Color.blue
            VStack{
                Text("New Spot").font(.largeTitle)
                VStack{
                    Text("Username")
                    TextField("Username", text: $username)
                        .focused($usernameFieldFocused)
                        .padding()
                        .border(Color.white)
                        .zIndex(1)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                }.padding()
                
                VStack{
                    Text("Password")
                    SecureField("Password", text: $password)
                        .focused($usernameFieldFocused)
                        .padding()
                        .border(Color.white)
                        .zIndex(1)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                }.padding()
                Button("Submit", action: {
                    validation(username: username, password: password)
                })
                Divider()
                VStack{
                    Text("Login using the following").padding()
                }
            }
            
        }.ignoresSafeArea().foregroundStyle(Color.white)
    }
}

#Preview {
    //LoginPage(logg)
}
