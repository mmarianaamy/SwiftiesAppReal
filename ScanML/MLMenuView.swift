//
//  menuView.swift
//  prueba
//
//  Created by Alumno on 11/01/24.
//

import SwiftUI

struct MLMenuView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background").ignoresSafeArea()
                
                VStack(){
                    HStack(alignment: .lastTextBaseline){
                        Spacer()
                        Image("LStar")
                    }
                    .frame(width: 300.0)
                    HStack(alignment: .firstTextBaseline){
                        Text("Identificador")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                    .frame(height: 90.0)

                    VStack{
                        NavigationLink(destination: CameraScanView(labelData: Classification())){
                            Text("escanea")
                                .foregroundColor(.white)
                                .font(Font.varButtonLabel)
                                .frame(width: 300.0, height: 50.0)
                                .background(Color("Secundarycolor"))
                                .cornerRadius(100)
                            
                        }
                        

                        
                    }.padding()
                    HStack(alignment: .firstTextBaseline){
                        Image("SStar")
                        Spacer()
                    }
                    .frame(width: 300.0)
                    
                    Image("Mascot").resizable().aspectRatio(contentMode: .fit).frame(width: 300.0, height: 300.0)
                }
            }
            .navigationTitle("Inicio").navigationBarHidden(true)
                
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    MLMenuView()
}
