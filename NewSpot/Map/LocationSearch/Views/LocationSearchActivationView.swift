//
//  LocationSearchActivationView.swift
//  New Spot
//
//  Created by Jorge Salcedo on 19/11/24.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            /*Circle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)*/
            Text("Buscar dirección")
                .foregroundStyle(Color(.darkGray))
                .padding(.leading)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
                .cornerRadius(15)
        )
    }
}

#Preview {
    LocationSearchActivationView()
}
