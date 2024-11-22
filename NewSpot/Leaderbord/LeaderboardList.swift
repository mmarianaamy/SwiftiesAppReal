//
//  LeaderboardList.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI

struct LeaderboardList: View {
    
    @EnvironmentObject var user: User
    
    @State var loading : Bool = false
    
    ///mock data
    @State var users: [LeaderboardUser] = []
    
    var body: some View {
        
        VStack{
            
            // Encabezados de la tabla
            HStack {
                Text("Puesto")
                    .font(.headline)
                    .frame(width: 60, alignment: .leading)
                Text("Nombre")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("# Hábitos")
                    .font(.headline)
                    .frame(width: 100, alignment: .trailing)
            }
            .padding(.horizontal)
            
            Divider() // Línea separadora

            ScrollView {
                LazyVStack(spacing: 10) {
                    /*if loading {
                        ProgressView()
                    }  else if users.isEmpty {
                        Text("Es agradable tener a alguien a tu lado. ¡Invita amigos!")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(users, id: \.self) { user in
                            LeaderbordRow(position: 0, name: String(user.idamigo), points: 0, prevPosition: 0)
                                .padding(.horizontal)
                        }
                    }*/
                    if loading {
                        ProgressView()
                    } else if users.isEmpty {
                        Text("Es agradable tener a alguien a tu lado. ¡Invita amigos!")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(users, id: \.id) { user in
                            LeaderbordRow(
                                position: users.firstIndex(of: user)! + 1, // Calcula la posición
                                name: user.username,
                                surname: user.surname, 
                                points: user.habits_count,
                                prevPosition: 0,
                                is_current_user: user.is_current_user
                            )
                            .padding(.horizontal)
                        }
                    }
                }
                .accentColor(.primary)
                .padding(.top)
                .task{
                    /*loading = true
                    do{
                        let usersBD : [LeaderboardUser]? = try await supabase.from("amigos").select("*").eq("idusuario", value: user.idusuario).execute().value
                        print(usersBD)
                        users = usersBD!
                        print("done")
                    } catch{
                        print("Not possible")
                    }
                    loading = false*/
                    await fetchLeaderboardData()
                    
                }
            }//.background(StaticGradientView())
        }
    }
    /*func fetchLeaderboardData() async {
        loading = true
        defer { loading = false }
        
        do {
            let response: [LeaderboardUser] = try await supabase
                .rpc("fetch_leaderboard") // O usa una consulta select si no tienes RPC
                .execute().value ?? []
            self.users = response
        } catch {
            print("Error al obtener datos: \(error)")
        }
    }*/
    func fetchLeaderboardData() async {
        loading = true
        defer { loading = false }
        
        do {
            var response: [LeaderboardUser] = try await supabase
            //let response: [LeaderboardUser] = try await supabase
                .rpc("fetch_leaderboard", params: ["user_id": user.idusuario])
                .execute()
                .value ?? []
            
            // Marcar al usuario actual en el ranking
            for i in 0..<response.count {
                if response[i].id == user.idusuario {
                    response[i].is_current_user = true
                }
            }
            ///
            
            self.users = response
        } catch {
            print("Error al obtener datos: \(error)")
        }
    }
}

#Preview {
    LeaderboardList().environmentObject(User(idusuario: 11))
}
