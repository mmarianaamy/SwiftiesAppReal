//
//  MLMenu.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 07/11/24.
//

import SwiftUI

struct MLMenu: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(){
                    HStack(alignment: .lastTextBaseline){
                        Spacer()
                        Image("LStar")
                    }
                    .frame(width: 300.0)
                    HStack(alignment: .firstTextBaseline){
                        Text("CADI").foregroundColor(Color(.white)).font(Font.varTitle)
                    }
                    .frame(height: 90.0)

                    VStack{
                        NavigationLink(destination: CameraScanView(labelData: Classification())){
                            Text("escanea")
                                .foregroundColor(.white)
                                .font(Font.varButtonLabel)
                                .frame(width: 300.0, height: 50.0)
                                .background(Color.black)
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
    MLMenu()
}
