//
//  ProfileView.swift
//  SwiftiesApp
//
//  Created by Carolina De los Santos Reséndiz on 01/11/24.
//

import SwiftUI

struct ProfileView: View {
    @State var nombre = ""
    @State var apellido = ""
    @State var email = ""
    @State var isLoading = false

    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
            Section {
              TextField("Nombre", text: $nombre)
                .textContentType(.name)
                .textInputAutocapitalization(.never)
              TextField("Apellido", text: $apellido)
                .textContentType(.familyName)
                HStack {
                    Text("Email")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(email)
                        .foregroundColor(.primary)
                }
            }

            Section {
                Button("Actualizar Perfil") {
                    updateProfileButtonTapped()
                }
                .bold()

                if isLoading {
                    ProgressView()
                }
            }
            }

            Section {
                Button("Cerrar Sesión") {
                    Task {
                        await logout()
                    }
                }
                .foregroundColor(.blue)
                .padding()
            }
            Spacer()
        }
        .task {
        await getInitialProfile()
        }
    }

    func getInitialProfile() async {
        do {
            let currentUser = try await supabase.auth.session.user
            
            // Establece el email del usuario autenticado en el campo de solo lectura
            self.email = currentUser.email!

            let usuario: Usuario = try await supabase
                .from("usuario")
                .select()
                .eq("auth_user_id", value: currentUser.id)
                .single()
                .execute()
                .value

            self.nombre = usuario.nombre ?? ""
            self.apellido = usuario.apellido ?? ""

        } catch {
        debugPrint(error)
        }
    }

    func updateProfileButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                let currentUser = try await supabase.auth.session.user

                try await supabase
                  .from("usuario")
                  .update(
                    UpdateProfileParams(
                      nombre: nombre,
                      apellido: apellido,
                      email: email
                    )
                  )
                  .eq("auth_user_id", value: currentUser.id)
                  .execute()
                print("Perfil actualizado exitosamente")
            } catch {
                debugPrint("Error al actualizar el perfil: \(error)")
            }
        }
    }
    func logout() async {
        do {
            try await supabase.auth.signOut()
            dismiss()
        } catch {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
}

struct UpdateProfileParams: Encodable {
    let nombre: String
    let apellido: String
    let email: String
}
