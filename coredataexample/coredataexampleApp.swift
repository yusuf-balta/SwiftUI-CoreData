//
//  coredataexampleApp.swift
//  coredataexample
//
//  Created by Yusuf Balta on 7.08.2022.
//

import SwiftUI

@main
struct coredataexampleApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
