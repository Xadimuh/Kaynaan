//
//  KaynanApp.swift
//  Kaynan
//
//  Created by comprendrien on 30/09/2023.
//

import SwiftUI

@main
struct KaynanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
