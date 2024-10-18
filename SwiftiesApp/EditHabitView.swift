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
    @State var frecuency : Int =  0
    @State var changeView : Bool = false
    
    init(habit: Habit) {
        self.habit = habit
        self.name = habit.name
        self.frecuency = habit.frecuency
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
                    Text(habit.name)
                    Text(String(habit.frecuency))
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
    EditHabit.init(habit: Habit(frecuency: 1, name: "Habit1", date: Date()))
}
