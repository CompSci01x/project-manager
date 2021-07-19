//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/4/21.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .navigationViewStyle(StackNavigationViewStyle())

        }
    }
}
