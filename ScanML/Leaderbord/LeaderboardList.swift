//
//  LeaderboardList.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI

struct LeaderboardList: View {
    
    ///mock data
    private var users: [LeaderboardUser] = [LeaderboardUser(name: "Luis", emissions: 93.2, position: 1, prevPosition: 2), LeaderboardUser(name: "Ximena", emissions: 53.9, position: 2, prevPosition: 1), LeaderboardUser(name: "Carlos", emissions: 34.2, position: 3, prevPosition: 3), LeaderboardUser(name: "Marina", emissions: 31.9, position: 4, prevPosition: 4), LeaderboardUser(name: "Lucy", emissions: 24.8, position: 5, prevPosition: 5)]
    
    var body: some View {
        
        VStack{
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(users, id: \.self) { user in
                        LeaderbordRow(position: user.position, name: user.name, points: user.emissions, prevPosition: user.prevPosition ?? user.position)
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
