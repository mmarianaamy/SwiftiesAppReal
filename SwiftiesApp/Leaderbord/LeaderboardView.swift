//
//  LeaderboardView.swift
//  SwiftiesApp
//
//  Created by Alumno on 16/10/24.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack{
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
                //.foregroundColor(.button)
                .foregroundStyle(Color.black)
            LeaderboardList().padding()
        }.background(StaticGradientView())
    }
}

#Preview {
    LeaderboardView()
}
