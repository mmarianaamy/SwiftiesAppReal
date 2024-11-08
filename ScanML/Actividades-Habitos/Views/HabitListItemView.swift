//
//  HabitListItemView.swift
//  SwiftiesApp
//
//  Created by Alumno on 11/10/24.
//

import SwiftUI

struct HabitListItem : View {
    var habit: HabitUser
    
    var body: some View {
        //Cambiar a nombre
        Text(habit.habito?.nombre ?? "Habito").swipeActions(allowsFullSwipe: false){
            
            Button(role: .destructive) {
                print("Delete the habit pls")
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
            
            NavigationLink{
                //DetallesActividadView(habitName: habit.name)
            } label: {
                Button {
                    print("Edit")
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                .tint(.yellow)
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        List{
            HabitListItem(habit: HabitUser(recurrencia: "dia", frecuencia: 7, cantidad: "jask", idhabito: 1, fechainicio: "Date()", fechafinal: nil, habito: Habit(idhabito: 1, nombre: "")))
        }
    }
}
