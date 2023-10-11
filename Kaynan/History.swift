//
//  History.swift
//  Kaynan
//
//  Created by Cheikh Ahmadou Bamba Kamara on 09/10/2023.
//

import Foundation
import SwiftUI

struct HistoryView: View {
    
    private let historyManager = WaterHistoryManager.shared
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        List(historyManager.getRecords(), id: \.date) { record in
            HStack {
                Text(dateFormatter.string(from: record.date)) // Utilisez le DateFormatter pour formater la date
                Spacer()
                Text(String(format: "%.2f mL", record.amount))
            }
        } //.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Cacher le bouton "Back"
        .navigationBarTitle("Historique")
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}


