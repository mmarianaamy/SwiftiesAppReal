//
//  SignUpView.swift
//  SwiftiesApp
//
//  Created by Carolina De los Santos Reséndiz on 01/11/24.
//

import SwiftUI
import Foundation

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var resultMessage = ""
    
    @State var isLoading = false
    @State private var showLogin = false

    var body: some View {
        ZStack {
            Color.background
            VStack {
                Text("New Spot").font(.largeTitle)
                Text("Crear Cuenta")
                    .font(.title3)
                    .padding(.bottom, -20)
                
                VStack (alignment: .leading){
                    Text("Email").padding(.horizontal)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                        )
                        .zIndex(1)
                        .autocorrectionDisabled()
                }
                .padding()
                            
                VStack (alignment: .leading){
                    Text("Password").padding(.horizontal)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                        )
                        .autocorrectionDisabled()
                }
                .padding()
                
                Button("Registrarme") {
                    Task {
                        resultMessage = await signUpWithURLSessionWithRetry(email: email, password: password)
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
                
                Text(resultMessage)
                    .foregroundColor(.red)
                    .padding()
                
                Button("¿Ya tienes una cuenta? Inicia Sesión") {
                    showLogin = true
                }
                .foregroundColor(.blue)
                .padding()

                NavigationLink(destination: LoginPage(logged: .constant(false)), isActive: $showLogin) {
                    EmptyView()
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .foregroundStyle(Color.white)
    }

    func signUpWithURLSessionWithRetry(email: String, password: String, maxRetries: Int = 3) async -> String {
        for attempt in 1...maxRetries {
            let result = await signUpWithURLSession(email: email, password: password)
            
            if !result.contains("upstream request timeout") {
                return result
            }
            
            print("Reintentando registro (intento \(attempt))...")
            try? await Task.sleep(nanoseconds: 2_000_000_000)
        }
        
        return "Error en el registro: tiempo de espera agotado después de varios intentos."
    }

    func signUpWithURLSession(email: String, password: String) async -> String {
        guard let url = URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co/auth/v1/signup") else {
            return "URL inválida"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let apiKey = "your-api-key-here"
        
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            return "Error al preparar el cuerpo de la solicitud: \(error)"
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                return "Registro exitoso"
            } else {
                let errorMessage = String(data: data, encoding: .utf8) ?? "Error desconocido"
                return "Error en el registro: \(errorMessage)"
            }
        } catch {
            return "Error en la solicitud de registro: \(error)"
        }
    }
}
