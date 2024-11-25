//
//  LocationsSearchResultCell.swift
//  New Spot
//
//  Created by Jorge Salcedo on 19/11/24.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(Color.blue)
                .tint(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)
                //Text("123 avenue de la république")
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .foregroundStyle(.primary)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
            
        }.padding(.horizontal)
    }
}

#Preview {
    LocationSearchResultCell(title: "name", subtitle: "street")
}
