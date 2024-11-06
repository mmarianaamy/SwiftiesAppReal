//
//  LoginPage.swift
//  SwiftiesApp
//
//  Created by Carolina De los Santos Reséndiz on 08/10/24.
//

import SwiftUI


struct LoginPage: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var resultMessage = ""
    @State private var showSignUp = false // State to show the registration screen
    @State private var isLoggedIn = false // State for navigation to ProfileView
    
    @State var isLoading = false
    @Binding var logged: Bool
    @EnvironmentObject var user: User

    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                Text("New Spot").font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text("Username").padding(.horizontal)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(Color.black)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                        .zIndex(1)
                        .autocorrectionDisabled()

                }.padding()


                
                VStack(alignment: .leading) {
                    Text("Password").padding(.horizontal)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(Color.black)
                        .cornerRadius(10)

                        .autocorrectionDisabled()
                }.padding()

                
                Button("Iniciar Sesión") {
                    Task {
                        await signInWithEmail(email: email, password: password)
                    }

                }
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

                Button("¿No tienes una cuenta? Regístrate") {
                    showSignUp = true
                }
                .foregroundColor(.blue)
                .padding()
                
                // Navegación a SignUpView
                NavigationLink(destination: SignUpView(), isActive: $showSignUp) {
                    EmptyView()
                }
                
                // Navegación a MenuView al iniciar sesión
                NavigationLink(destination: MenuView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
            }.zIndex(1)
            .padding()
        }.ignoresSafeArea()

            .foregroundStyle(Color.white)
            
            if isLoading {
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView().padding().background(Color.white).cornerRadius(10)
            }
        }
    }

    func signInWithEmail(email: String, password: String) async {
        do {
            try await supabase.auth.signIn(email: email, password: password)
            resultMessage = "Inicio de sesión exitoso con correo y contraseña."
            DispatchQueue.main.async {
                self.isLoggedIn = true // Navigate to ProfileView on successful login
            }
        } catch {
            resultMessage = "Error al iniciar sesión: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
