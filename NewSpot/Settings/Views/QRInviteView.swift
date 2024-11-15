//
//  QRInviteView.swift
//  New Spot
//
//  Created by Jorge Salcedo on 15/11/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Supabase

struct QRInviteView: View {
    @EnvironmentObject var user: User
    @State private var scannedCode: String = ""
    @State private var isScanning: Bool = false
    
    @State private var supabaseClient = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")

    var body: some View {
        VStack(spacing: 20) {
            Text("Invitar a un amigo")
                .font(.largeTitle)
                .padding()

            Text("Muestra este código a un amigo para agregarlo")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            if let friendCode = user.idusuario != 0 ? "User\(user.idusuario)" : nil,
               let qrImage = generateQRCode(from: friendCode) {
                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 200, height: 200)
            } else {
                Text("Error al generar el código QR")
                    .foregroundColor(.red)
            }

            if user.idusuario != 0 {
                Text("Código: User\(user.idusuario)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Text("Cargando información del usuario...")
                    .foregroundColor(.gray)
            }

            Button(action: {
                isScanning = true
            }) {
                Text("Escanear código de amigo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .background(
                NavigationLink("", destination: QRScannerView(scannedCode: $scannedCode), isActive: $isScanning)
                    .hidden()
            )
        }
        .padding()
        .onChange(of: scannedCode) { newValue in
            if !newValue.isEmpty {
                print("Scanned code: \(newValue)")

                let userIdString = newValue.replacingOccurrences(of: "User", with: "")
                
                if let userId = Int(userIdString) {
                    print("Extracted user ID: \(userId)")

                    let currentUserId = user.idusuario
                    
                    Task {
                        do {
                            try await supabaseClient.from("amigos").insert([
                                ["idusuario": currentUserId, "idamigo": userId]
                            ]).execute()
                            
                            try await supabaseClient.from("amigos").insert([
                                ["idusuario": userId, "idamigo": currentUserId]
                            ]).execute()

                            print("Friend added successfully")
                        } catch {
                            print("Error adding friend: \(error.localizedDescription)")
                        }
                    }
                } else {
                    print("Invalid user ID scanned")
                }
            }
        }
    }

    /// Function to generate a QR code image from a string.
    func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return nil
    }
}


#Preview {
    QRInviteView().environmentObject(User(idusuario: 16, nombre: "Juan", apellido: "", email: "", contraseña: ""))
}
