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
            VStack{
                Form {
                Section {
                  TextField("Nombre", text: $nombre)
                    .textContentType(.name)
                    .textInputAutocapitalization(.never)
                  TextField("Apellido", text: $apellido)
                    .textContentType(.familyName)
                    /*HStack {
                        Text("Email")
                            .foregroundColor(.gray)
                        Spacer()
                        Text(email)
                            .foregroundColor(.primary)
                    }*/
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
                    NavigationLink(destination: ContentView()) {
                        Text("Cerrar Sesion")
                            .padding()
                            .foregroundStyle(.blue)
                    }.onTapGesture {
                        Task {
                            await logout()
                        }
                    }

                }
                Spacer()
            }.padding(.top, -8)
            
        }
        .task {
        await getInitialProfile()
        }
    }

    func getInitialProfile() async {
        do {
            let currentUser = try await supabase.auth.session.user
            ///
            debugPrint("Usuario autenticado ID: \(currentUser.id)")
            debugPrint("Usuario autenticado email: \(currentUser.email ?? "")")
            ///
            
            // Establece el email del usuario autenticado en el campo de solo lectura
            //self.email = currentUser.email!

            /*let usuario: Usuario = try await supabase
                .from("usuario")
                .select()
                ///
                .eq("email", value: currentUser.email)
            ///
                //.eq("auth_user_id", value: currentUser.id)
                //.single()
                .execute()
                .value*/
            
            // Recuperar datos del usuario
            let usuario: Usuario? = try await supabase
                .from("usuario")
                .select()
                .eq("auth_user_id", value: currentUser.id) // Asegúrate de usar este campo como filtro
                .single()
                .execute()
                .value
            
            if let usuario = usuario {
                self.nombre = usuario.nombre ?? ""
                self.apellido = usuario.apellido ?? ""
                debugPrint("Datos recuperados: \(usuario)")
            } else {
                debugPrint("No se encontraron datos para el usuario.")
            }
            
            ///
            /*debugPrint("Datos recuperados: \(usuario)")
            ///

            self.nombre = usuario.nombre
            self.apellido = usuario.apellido
            //self.nombre = usuario.nombre ?? ""
            //self.apellido = usuario.apellido ?? ""*/

        } catch {
            debugPrint("Error al obtener el perfil: \(error)")
            //debugPrint(error)
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

#Preview{
    ProfileView()
}
