//
//  LeaderbordRow.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI

struct LeaderbordRow: View {
    
    /*var position: Int
     var name: String
     var points: Double
     var prevPosition: Int*/
    
    let position: Int
    let name: String
    let points: Int
    let prevPosition: Int
    
    var body: some View {
        VStack {
            HStack{
                Text("\(position)")
                    .bold()
                    .frame(width: 30, alignment: .leading)
                Text(name)
                    .font(.headline)
                Spacer()
                Text("\(points) hábitos")
                    .foregroundColor(.gray)
                /*if prevPosition < position {
                 Image(systemName: "chevron.compact.down")
                 .font(.headline)
                 .padding(.horizontal)
                 .foregroundStyle(.red)
                 .bold()
                 } else if prevPosition > position {
                 Image(systemName: "chevron.compact.up")
                 .font(.headline)
                 .padding(.horizontal)
                 .foregroundStyle(.green)
                 .bold()
                 } else {
                 Image(systemName: "chevron.compact.right")
                 .font(.headline)
                 .padding(.horizontal)
                 .foregroundStyle(.gray)
                 .bold()
                 }
                 
                 Text("\(position)").font(.title)
                 .padding(.trailing)
                 Text(name).font(.title)
                 Spacer()
                 Text("\(String(format: "%.2f", points))")
                 .padding(.horizontal)
                 .font(.headline)
                 }.padding(.vertical, 8)*/
            }
            /*.background(position == 1 ? RoundedRectangle(cornerRadius: 20).stroke(Color.gray).fill(Color.customBlue1) :
             position == 2 ? RoundedRectangle(cornerRadius: 20).stroke(Color.gray).fill(Color.customBlue2) :
             position == 3 ? RoundedRectangle(cornerRadius: 20).stroke(Color.gray).fill(Color.customBlue3) :
             RoundedRectangle(cornerRadius: 20).stroke(Color.gray).fill(Color.customBlue4))
             */
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20
                                )
                .stroke(Color.gray)
                .fill(Color.white))
        }
    }
}

/*#Preview {
 LeaderbordRow(position: 1, name: "Test", points: 32, prevPosition: 1)
 }*/


#Preview {
    LeaderboardList().environmentObject(User(idusuario: 11))
}
