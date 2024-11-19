//
//  MapViewActionButton.swift
//  New Spot
//
//  Created by Jorge Salcedo on 19/11/24.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var showLocationSearchView: Bool
    var body: some View {
            Button{
                withAnimation(.spring()){
                    showLocationSearchView.toggle()
                }
            }
            label: {
                Image(systemName: showLocationSearchView==true ? "chevron.left" : "line.3.horizontal")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    //.shadow(color: .black, radius: 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MapViewActionButton(showLocationSearchView: .constant(true))
}
