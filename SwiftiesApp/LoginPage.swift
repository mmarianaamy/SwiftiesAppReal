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
            Color.background
            VStack{
                Text("New Spot").font(.largeTitle)
                VStack(alignment: .leading){
                    Text("Username").padding(.horizontal)
                    TextField("Username", text: $username)
                        .focused($usernameFieldFocused)
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                        )
                        .zIndex(1)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                }.padding()
                
                VStack(alignment: .leading){
                    Text("Password").padding(.horizontal)
                    SecureField("Password", text: $password)
                        .focused($usernameFieldFocused)
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                        )
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                }.padding()
                HStack{
                    Spacer()
                    Text("Forgot password?").padding(.horizontal)
                }
                Button("Log in", action: {
                    validation(username: username, password: password)
                })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.button)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(.button, lineWidth: 1)
                    ).padding()
                Divider().overlay(Color.white).padding()
                VStack{
                    Text("Login using the following").padding()
                }
            }.zIndex(1)
            
        }.ignoresSafeArea().foregroundStyle(Color.white)
    }
}

#Preview {
    ContentView()
}
