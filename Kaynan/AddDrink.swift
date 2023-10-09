//
//  AddDrink.swift
//  Kaynan
//
//  Created by Cheikh Ahmadou Bamba Kamara on 09/10/2023.
//

import Foundation
import SwiftUI

struct AddDrinkView: View {
    
    @Binding var waterDrank: Double // Binding vers waterDrank pour mettre à jour la valeur
    @State private var quantity: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color(UIColor(red: 0x9C / 255.0, green: 0xB3 / 255.0, blue: 0xC7 / 255.0, alpha: 1.0))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Ajouter de l'eau")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                TextField("Quantité (ml)", text: $quantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .padding()
                
                Button(action: {
                    if let quantityValue = Double(quantity) {
                        waterDrank += quantityValue
                        quantity = ""
                        presentationMode.wrappedValue.dismiss() // Masquer la vue

                        let currentDate = Date() // Obtenez la date actuelle
                        let waterRecord = WaterRecord(date: currentDate, amount: quantityValue) // Utilisez la date actuelle et la quantité entrée par l'utilisateur

                        WaterHistoryManager.shared.saveRecord(waterRecord)
                    }
                }) {
                    Text("Ajouter")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1.0)))
                        .cornerRadius(10)
                }
                .padding()


                
                Spacer()
            }
        }
    }
}

struct AddDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        AddDrinkView(waterDrank: .constant(1000.0)) // Exemple avec une valeur initiale pour waterDrank
    }
}
