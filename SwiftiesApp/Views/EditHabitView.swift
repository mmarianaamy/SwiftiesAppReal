//
//  EditHabitView.swift
//  SwiftiesApp
//
//  Created by Alumno on 11/10/24.
//

import SwiftUI

struct EditHabit : View {
    var habit : Habit
    
    @State var name : String =  ""
    @State var changeView : Bool = false
    
    init(habit: Habit) {
        self.habit = habit
        self.name = habit.nombre
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(){
                    changeView = !changeView
                }label: {
                    Image(systemName: "pencil").resizable().frame(width: 30, height: 30).scaledToFit()
                }
            }.padding()
            if !changeView{
                VStack{
                    Text(habit.nombre)
                }
            }else{
                VStack{
                    TextField("Habit Name", text: $name)
                }.padding()
            }
        }
    }
}

#Preview {
    EditHabit(habit: Habit(idhabito: 1, nombre: "Habit1"))
}
