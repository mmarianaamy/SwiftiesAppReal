//
//  SignUpView.swift
//  SwiftiesApp
//
//  Created by Carolina De los Santos Reséndiz on 01/11/24.
//

import SwiftUI
import Foundation

struct SignUpView: View {
    
    enum AlertType: Identifiable {
        case invalidEmail
        case weakPassword
        case duplicatedEmail
        case missingFields
        
        var id: String {
            switch self {
            case .invalidEmail:
                return "invalidEmail"
            case .weakPassword:
                return "weakPassword"
            case .duplicatedEmail:
                return "duplicatedEmail"
            case .missingFields:
                return "missingFields"
            }
        }
    }
    
    @State private var email = ""
    @State private var password = ""
    @State private var nombre = ""
    @State private var apellido = ""
    @State private var resultMessage = ""
    
    @State private var activeAlert: AlertType? = nil
    
    @State var isLoading = false
    //@State private var isLoggedIn = false
    @State private var showPasswordAlert = false
    @State private var showEmailAlreadyExistsAlert = false
    @State private var duplicatedEmailMessage = ""
    //@State private var emailErrorMessage = "" // Mensaje de error para el formato de correo
    @State private var showInvalidEmailAlert = false
    @State private var invalidEmailMessage = ""
    @State private var navigateToNextView = false // Variable para navegación
    
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: User
    
    @Binding var showAlert: Bool
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.background
                VStack {
                    Text("New Spot").font(.largeTitle)
                    Text("Crear Cuenta")
                        .font(.title3)
                        .padding(.bottom, 10)
                    
                    ///
                    VStack(alignment: .leading) {
                        Text("Nombre").padding(.horizontal)
                        TextField("Nombre", text: $nombre)
                            .textContentType(.givenName)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding(13)
                            .background(Color.white)
                            .foregroundStyle(Color.black)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                            .zIndex(1)
                            .autocorrectionDisabled()
                        
                    }.padding(.bottom, -5)
                        .padding(.horizontal, 15)
                        .padding(.top, 15)
                    
                    VStack(alignment: .leading) {
                        Text("Apellido").padding(.horizontal)
                        TextField("Apellido", text: $apellido)
                            .textContentType(.familyName)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding(13)
                            .background(Color.white)
                            .foregroundStyle(Color.black)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                            .zIndex(1)
                            .autocorrectionDisabled()
                        
                    }.padding(.bottom, -5)
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                    ///
                    
                    VStack (alignment: .leading){
                        Text("Email").padding(.horizontal)
                        TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding(13)
                            .background(Color.white)
                            .foregroundStyle(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                            )
                            .zIndex(1)
                            .autocorrectionDisabled()
                    }.padding(.bottom, -5)
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                    
                    VStack (alignment: .leading){
                        Text("Password").padding(.horizontal)
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .textInputAutocapitalization(.never)
                            .padding(13)
                            .background(Color.white)
                            .foregroundStyle(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                            )
                            .autocorrectionDisabled()
                    }
                    .padding(.bottom, 15)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    
                    // Botón de Registro
                    Button("Registrarme") {
                    
                        if nombre.isEmpty || apellido.isEmpty {
                            activeAlert = .missingFields
                        } else if isPasswordWeak(password) {
                            activeAlert = .weakPassword
                        } else {
                            Task {
                                isLoading = true
                                defer { isLoading = false }
                                
                                resultMessage = await signUpWithURLSessionWithRetry(nombre: nombre, apellido: apellido, email: email, password: password)
                                
                                
                                if resultMessage.contains("exitosamente") {
                                    DispatchQueue.main.async {
                                        navigateToNextView = true
                                        showAlert = true
                                    }
                                } else {
                                    // Asegúrate de que las alertas sean visibles
                                    print("Resultado: \(resultMessage)") // Depuración
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.button)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.button, lineWidth: 1))
                    .padding()
                    
                    
                    NavigationLink(destination: MenuView(), isActive: $navigateToNextView) {
                        EmptyView()
                    }
                    
                    Button("¿Ya tienes una cuenta? Inicia Sesión") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                    .padding()
                }
            }
        }
        .ignoresSafeArea()
        .foregroundStyle(Color.white)

        .alert(item: $activeAlert) { alertType in
            switch alertType {
            case .invalidEmail:
                return Alert(
                    title: Text("Formato de correo inválido"),
                    message: Text(invalidEmailMessage),
                    dismissButton: .default(Text("OK"))
                )
            case .weakPassword:
                return Alert(
                    title: Text("Contraseña débil"),
                    message: Text("Tu contraseña debe tener al menos 8 caracteres, incluyendo letras y números."),
                    dismissButton: .default(Text("OK"))
                )
            case .duplicatedEmail:
                return Alert(
                    title: Text("Correo duplicado"),
                    message: Text(duplicatedEmailMessage),
                    //message: Text(message),
                    dismissButton: .default(Text("OK"))
                )
            case .missingFields:
                return Alert(
                    title: Text("Campos obligatorios"),
                    message: Text("Por favor, llena los campos de Nombre y Apellido."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func isPasswordWeak(_ password: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return !predicate.evaluate(with: password)
    }
    
    func signUpWithURLSessionWithRetry(nombre: String, apellido: String, email: String, password: String, maxRetries: Int = 3) async -> String {
        for attempt in 1...maxRetries {
            let result = await signUpWithURLSession(nombre: nombre, apellido: apellido, email: email, password: password)
            
            if !result.contains("upstream request timeout") {
                return result
            }
            
            print("Reintentando registro (intento \(attempt))...")
            try? await Task.sleep(nanoseconds: 2_000_000_000)
        }
        
        return "Error en el registro: tiempo de espera agotado después de varios intentos."
    }
    
    func signUpWithURLSession(nombre: String, apellido: String, email: String, password: String) async -> String {
     guard let url = URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co/auth/v1/signup") else {
     return "URL inválida"
     }
     
     var request = URLRequest(url: url)
     request.httpMethod = "POST"
     let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc"
     
     
     request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
     request.addValue(apiKey, forHTTPHeaderField: "apikey")
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
     let body: [String: Any] = [
     "email": email,
     "password": password,
     "data": [
     "nombre": nombre,
     "apellido": apellido
     ]
     ]
     
     do {
     let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
     request.httpBody = jsonData
     } catch {
     return "Error al preparar el JSON: \(error)"
     }
     
     do {
     let (data, response) = try await URLSession.shared.data(for: request)
     
     if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
     
     // Registro exitoso, iniciar sesión automáticamente
     let loginResult = await signInWithEmail(email: email, password: password)
     if loginResult.contains("Inicio de sesión exitoso") {
     return "Registro y sesión iniciados exitosamente"
     } else {
     return "Registro exitoso, pero ocurrió un error al iniciar sesión: \(loginResult)"
     }
     } else {
     let errorMessage = String(data: data, encoding: .utf8) ?? "Error desconocido"
     
     // Imprimir el mensaje de error para depuración
     print("Error en el registro: \(errorMessage)")
     
     
     if errorMessage.contains("validation_failed") {
     DispatchQueue.main.async {
     self.invalidEmailMessage = "El formato del correo es inválido. Por favor, verifica tu correo."
     self.activeAlert = .invalidEmail
     //self.showInvalidEmailAlert = true
     
     }
     }
     if errorMessage.contains("user_already_exists") {
     DispatchQueue.main.async {
     self.duplicatedEmailMessage = "El correo ya está registrado. Por favor, intenta con otro correo."
     //self.showEmailAlreadyExistsAlert = true
     self.activeAlert = .duplicatedEmail
     print("Activando alerta de correo duplicado") // Depuración
     }
     }
     return "Error en el registro: \(errorMessage)"
     }
     } catch {
     return "Error en la solicitud de registro: \(error)"
     }
     }
    
    func signInWithEmail(email: String, password: String) async -> String {
        do {
            try await supabase.auth.signIn(email: email, password: password)
            return "Inicio de sesión exitoso con correo y contraseña."
        } catch {
            return "Error al iniciar sesión: \(error.localizedDescription)"
        }
    }
}
