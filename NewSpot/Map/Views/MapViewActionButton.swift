//
//  MapViewActionButton.swift
//  New Spot
//
//  Created by Jorge Salcedo on 19/11/24.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    var body: some View {
            Button{
                withAnimation(.spring()){
                    actionForState(mapState)
                }
            }
            label: {
                Image(systemName: imageNameForState(mapState))
                    .font(.title2)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    //.shadow(color: .black, radius: 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected, .searchingForLocation:
            return "chevron.left"
        }
    }
    
    func actionForState(_ state: MapViewState){
        switch state {
        case .noInput:
            print("No input")
        case .locationSelected:
            mapState = .noInput
        case .searchingForLocation:
            //print("Searching for location")
            mapState = .noInput
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput))
}
