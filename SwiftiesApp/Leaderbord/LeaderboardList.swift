//
//  LeaderboardList.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI

struct LeaderboardList: View {
    
    ///mock data
    private var users: [LeaderboardUser] = [LeaderboardUser(idusuario: 1, name: "", emissions: nil, position: nil, prevPosition: nil)]
    
    var body: some View {
        
        VStack{
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(users, id: \.self) { user in
                        LeaderbordRow(name: user.name)
                            .padding(.horizontal)
                    }
                }
                .accentColor(.primary)
                .padding(.top)
            }//.background(StaticGradientView())
        }
    }
}

#Preview {
    LeaderboardList()
}
