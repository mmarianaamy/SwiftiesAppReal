//
//  LocationSearchView.swift
//  New Spot
//
//  Created by Jorge Salcedo on 19/11/24.
//

import SwiftUI

struct LocationSearchView: View {
    //@Binding var showLocationSearchView: Bool
    @State private var startLocation: String = ""
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState
    var body: some View {
        VStack{
            ///header view
            HStack{
                VStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 1, height: 14)
                    
                    Image(systemName: "mappin")
                        .foregroundStyle(Color.red)
                        .tint(Color.red)
                        .frame(height: 6)
                        .padding(.top, 2)
                        
                }
                
                VStack{
                    TextField("Ubicación inicial", text: $startLocation)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Destino", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            ///list view
            ScrollView{
                VStack(alignment: .leading){
                    //dummy data
                    ForEach(viewModel.results, id: \.self){ result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                viewModel
                                //.selectLocation(result.title)
                                .selectLocation(result)
                                //showLocationSearchView.toggle()
                                if mapState != .locationSelected {
                                        mapState = .locationSelected
                                    }
                            }
                    }
                }
            }
        }.background(Color.white)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.searchingForLocation))
}
