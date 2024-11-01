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
    
    @State private var errorMessage: String?
    
    @State var isLoading = false
    
    @StateObject var user = User()
    
    private let apiURL = "https://hyufiwwpfhtovhspewlc.supabase.co/rest/v1/usuario"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc"
    
    func validation(username: String, password: String) {
        guard let url = URL(string: "\(apiURL)?email=eq.\(username)&contraseña=eq.\(password)&select=idusuario,nombre,apellido") else {
            print("URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error en la solicitud: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No se recibieron datos"
                }
                return
            }

            do {
                let usuarios = try JSONDecoder().decode([Usuario].self, from: data)
                if !usuarios.isEmpty {
                    DispatchQueue.main.async {
                        self.logged = true
                        self.errorMessage = nil
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Contraseña incorrecta. Vuelve a intentarlo o haz clic en Contraseña olvidada para cambiarla"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error al decodificar los datos: \(error.localizedDescription)"
                }
            }
        }.resume()
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
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(errorMessage == "Contraseña incorrecta. Vuelve a intentarlo o haz clic en Contraseña olvidada para cambiarla" ? Color.red : Color.gray, lineWidth: 2)
                        )
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                }.padding()
                
                if let errorMessage = errorMessage {
                    ZStack {
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .offset(x: -0.5, y: -0.5)
                        
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    .padding()
                }
                
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
                
                if isLoading {
                    ProgressView()
                        .padding()
                }
                
                Divider().overlay(Color.white).padding()
                VStack{
                    Text("Login using the following").padding()
                }
            }.zIndex(1)
            
        }.ignoresSafeArea()
            .foregroundStyle(Color.white)
            .environmentObject(user)
    }
}

#Preview {
    ContentView()
}
