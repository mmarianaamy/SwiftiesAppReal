//
//  HabitListItemView.swift
//  SwiftiesApp
//
//  Created by Alumno on 11/10/24.
//

import SwiftUI

struct HabitListItem : View {
    var habit: Habit
    var body: some View {
        Text(habit.name).swipeActions(allowsFullSwipe: false){
            
            Button(role: .destructive) {
                print("Delete the habit pls")
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
            
            NavigationLink{
                EditHabit(habit: habit)
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
            HabitListItem(habit: Habit(id: 1, frecuency: 1, name: "Habit1", date: Date()))
        }
    }
}
