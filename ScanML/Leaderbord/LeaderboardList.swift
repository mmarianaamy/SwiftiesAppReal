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
            ScrollView {
                LazyVStack(spacing: 10) {
                    if loading {
                        ProgressView()
                    }
                    ForEach(users, id: \.self) { user in
                        LeaderbordRow(position: 0, name: String(user.idamigo), points: 0, prevPosition: 0)
                            .padding(.horizontal)
                    }
                }
                .accentColor(.primary)
                .padding(.top)
                .task{
                    loading = true
                    do{
                        let usersBD : [LeaderboardUser]? = try await supabase.from("amigos").select("*").eq("idusuario", value: user.idusuario).execute().value
                        print(usersBD)
                        users = usersBD!
                        print("done")
                    } catch{
                        print("Not possible")
                    }
                    loading = false
                    
                }
            }//.background(StaticGradientView())
        }
    }
}

#Preview {
    LeaderboardList().environmentObject(User(idusuario: 11))
}
