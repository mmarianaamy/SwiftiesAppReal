import SwiftUI

struct TimeButtonsView: View {
    @Binding var selectedTime: String  // Binding para cambiar el estado en la vista principal
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTime = "7 días"
            }) {
                Text("7 días")
                    .font(.body)
                    .foregroundColor(selectedTime == "7 días" ? .white : .black)
                    .padding()
                    .background(selectedTime == "7 días" ? Color.blue : Color(.systemGray6))
                    .cornerRadius(10)
            }
            
            Button(action: {
                selectedTime = "30 días"
            }) {
                Text("30 días")
                    .font(.body)
                    .foregroundColor(selectedTime == "30 días" ? .white : .black)
                    .padding()
                    .background(selectedTime == "30 días" ? Color.blue : Color(.systemGray6))
                    .cornerRadius(10)
            }
            
            Button(action: {
                selectedTime = "12 meses"
            }) {
                Text("12 meses")
                    .font(.body)
                    .foregroundColor(selectedTime == "12 meses" ? .white : .black)
                    .padding()
                    .background(selectedTime == "12 meses" ? Color.blue : Color(.systemGray6))
                    .cornerRadius(10)
            }
        }
    }
}
