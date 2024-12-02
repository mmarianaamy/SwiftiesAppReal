//
//  LoginPage.swift
//  SwiftiesApp
//
//  Created by Carolina De los Santos Reséndiz on 08/10/24.
//

import SwiftUI
import Supabase

struct LoginPage: View {
    enum AlertType: Identifiable {
        case userNotFound
        case incorrectPassword
        case genericError(String)

        var id: String {
            switch self {
            case .userNotFound:
                return "userNotFound"
            case .incorrectPassword:
                return "incorrectPassword"
            case .genericError:
                return "genericError"
            }
        }
    }
    
    @ObservedObject var state: LoginPageState
    @State private var email = ""
    @State private var password = ""
    @State var resultMessage = ""
    @State private var isLoggedIn = false
    @State private var activeAlert: AlertType? = nil
    @State private var showAlert = false
    
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
                    Text("Email").padding(.horizontal)
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
                
                NavigationLink(destination: SignUpView(showAlert: $showAlert).navigationTitle("")
                    .navigationBarBackButtonHidden()
                    .toolbar(.hidden)
                ) {
                    Text("¿No tienes una cuenta? Regístrate")
                        .foregroundStyle(Color.white)
                }
                .padding()
                .navigationTitle("")
                .navigationBarBackButtonHidden()
                .toolbar(.hidden)
   
                NavigationLink(destination: MenuView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
            }.zIndex(1)
                .padding()
        }
        .ignoresSafeArea()
        .foregroundStyle(Color.white)
        
        .alert(item: $activeAlert) { alertType in
            switch alertType {
            case .userNotFound:
                return Alert(
                    title: Text("Usuario no encontrado"),
                    message: Text("No encontramos una cuenta con este correo. ¿Deseas crear una?"),
                    primaryButton: .default(Text("Crear cuenta")) {
                        // Navega a la vista de registro
                        DispatchQueue.main.async {
                            self.logged = false
                            self.showAlert = true
                        }
                    },
                    secondaryButton: .cancel(Text("Cancelar"))
                )
            case .incorrectPassword:
                return Alert(
                    title: Text("Contraseña incorrecta"),
                    message: Text("La contraseña ingresada es incorrecta. Por favor, inténtalo de nuevo."),
                    dismissButton: .default(Text("OK"))
                )
            case .genericError(let message):
                return Alert(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        
        if isLoading {
            Color.black.opacity(0.5).ignoresSafeArea()
            ProgressView().padding().background(Color.white).cornerRadius(10)
        }
    }
    
    func signInWithEmail(email: String, password: String) async {
        do {
            try await supabase.auth.signIn(email: email, password: password)
            resultMessage = "Inicio de sesión exitoso con correo y contraseña."
            DispatchQueue.main.async {
                self.isLoggedIn = true
            }
            await user.changeValue(email: email)
        } catch let error as Auth.AuthError {
            // Capturamos el código de error específico
            let errorCode = error.errorCode.rawValue.lowercased()
            let errorMessage = error.message.lowercased()

            // Manejo de errores específicos
            if errorCode == "invalid_credentials" || errorMessage.contains("invalid login credentials") {
                activeAlert = .genericError("El correo o la contraseña son incorrectos. Por favor, verifica tus datos e inténtalo nuevamente.")
            } else {
                activeAlert = .genericError("Ocurrió un error inesperado. Por favor, intenta más tarde.")
            }
        } catch {
            // Manejo de otros errores genéricos
            activeAlert = .genericError("Ocurrió un error inesperado. Por favor, intenta más tarde.")
        }
    }
}

extension LoginPage {
    func getEmail() -> String {
        return email
    }

    func getPassword() -> String {
        return password
    }
}

#Preview {
    ContentView()
}
