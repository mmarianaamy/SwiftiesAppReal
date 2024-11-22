import SwiftUI
import Supabase

struct AgregarCompraView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var page: Int = 0
    @State var selectedProduct: Int
    @State var count: Int = 1
    @EnvironmentObject var user: User
    var updating : Bool = false
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")

    init(selectedProduct: Int = -1, updating : Bool = false){
        self.selectedProduct = selectedProduct
        self.updating = updating
        print(selectedProduct)
    }
    
    var body: some View {
        VStack {
            if !updating{
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Salir")
                    }
                    Spacer()
                }.padding()
            }
            
            if page == 0 {
                BuscarProductoView(selectedProduct: $selectedProduct, updating: updating, page: $page)
            } else {
                VStack {
                    Text("Ingresa cantidad")
                    Button {
                        count += 1
                    } label: {
                        Text("+")
                    }
                    HStack {
                        TextField("1", value: $count, format: .number).multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                    
                    Button {
                        if count > 1 {
                            count -= 1
                        }
                    } label: {
                        Text("-")
                    }
                }
                
                if !updating{
                    Button {
                        addProduct()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Listo")
                    }
                }
            }
            Spacer()
        }
    }
    
    private func addProduct() {
        guard selectedProduct != -1 else {
            return
        }
        
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: currentDate)
        let formattedDate = Int(dateString) ?? 0  // Convert the string to an integer

        Task {
            do {
                let result = try await client.from("usuario_producto")
                    .insert([
                        "idusuario": user.idusuario,
                        "idproducto": selectedProduct,
                        "cantidad": count,
                        "fecha": formattedDate
                    ]).execute()

            } catch {
                print("Error al agregar el producto: \(error.localizedDescription)")
            }
        }
    }




}

#Preview {
    AgregarCompraView()
}
