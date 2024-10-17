//
//  LeaderboardView.swift
//  SwiftiesApp
//
//  Created by Alumno on 16/10/24.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        Text("Friends").font(.largeTitle)
        HStack{
            Spacer()
            Text("Nancy").font(.title3)
            Spacer()
        }.frame(width: .infinity,height: 30).border(Color.button).padding()
    }
}

#Preview {
    LeaderboardView()
}
