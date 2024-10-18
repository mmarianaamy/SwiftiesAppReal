//
//  MultipleResponseView.swift
//  SwiftiesApp
//
//  Created by Alumno on 16/10/24.
//

import SwiftUI

struct Choice : View{
    @Binding var selection : Int
    var id : Int
    var body : some View {
        HStack{
            Button{
                selection = id
            } label: {
                Spacer()
                Text("14 a 18").frame(height: 50)
                Spacer()
            }.foregroundStyle(Color.black)
                .background(self.selection == id ? .button : Color(.clear))
                .border(self.selection != id ? .button : Color(.clear))
        }.padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            
    }
}

struct MultipleResponseView: View {
    @State var selection : Int = 0
    var body: some View {
        VStack{
            Choice(selection: $selection, id: 0)
            Choice(selection: $selection, id: 1)
        }
    }
}

#Preview {
    MultipleResponseView()
}
