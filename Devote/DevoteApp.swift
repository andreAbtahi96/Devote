//
//  DevoteApp.swift
//  Devote
//
//  Created by Andre Abtahi on 8/18/21.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                
                /*
                 managedObjectContext in the environment stores active data context.
                 the managedObjectContext is available for all views!
                 */
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
