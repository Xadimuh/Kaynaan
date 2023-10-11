import SwiftUI

struct AddDrinkView: View {
    @Binding var waterDrank: Double
    @State private var quantity: Double = 0 // Utilisez Double pour stocker la quantité d'eau en millilitres
    @Environment(\.presentationMode) var presentationMode
//    @Binding var isShowingHomePage: Bool // Variable d'état pour gérer la navigation vers la page d'accueil
    
    var body: some View {
        NavigationView{
        ZStack {
            Color(UIColor(red: 0x9C / 255.0, green: 0xB3 / 255.0, blue: 0xC7 / 255.0, alpha: 1.0))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("ADD DRINK")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Stepper(value: $quantity, in: 0...10000, step: 100) {
                    Text("\(Int(quantity)) ml")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding()
                
                Button(action: {
                    if quantity > 0 {
                        waterDrank += quantity
//                        quantity = 0
                        presentationMode.wrappedValue.dismiss() // Masquer la vue

                        let currentDate = Date()
                        let waterRecord = WaterRecord(date: currentDate, amount: quantity)
                        WaterHistoryManager.shared.saveRecord(waterRecord)
                        
                        // Définissez la variable d'état pour naviguer vers la page d'accueil
//                        isShowingHomePage = true
                    }
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(false) // Cacher le bouton "Back"
    }
}

struct AddDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        AddDrinkView(waterDrank: .constant(1000.0)) // Exemple avec une valeur initiale pour waterDrank
    }
}
}
