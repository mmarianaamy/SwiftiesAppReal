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
        ZStack(alignment: .top) {
            GeometryReader { reader in
                Color.white
                //.frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
                    .frame(height: 75)
            }.frame(height: 75)
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.button)
                Spacer()
            }.padding()
                .padding(.horizontal)
        }
    }
}

#Preview {
    topView(title: "Tus Huellas")
}
