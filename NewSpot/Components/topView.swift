//
//  topView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 17/10/24.
//

import SwiftUI

struct topView: View {
    
    var title: String
    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .top) {
                Color.background
                    .ignoresSafeArea()
                
                HStack {
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .padding(.horizontal)
            }
            .frame(height: 75)
        }
        .frame(height: 75) 
    }
}

#Preview {
    topView(title: "Tus Huellas")
}
