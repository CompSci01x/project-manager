//
//  Persistence.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/4/21.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for num in 0..<10 {
            let newProject = Project(context: viewContext)

            newProject.timestamp = Date()
            newProject.projectName = "Preview Name"
            newProject.projectDescription = "Preview Description"
            do {
                try newProject.projectCardColor = NSKeyedArchiver.archivedData(withRootObject: UIColor.green,
                                                                        requiringSecureCoding: false)
            } catch {
                print(error)
            }
            
            for teamNum in 0..<3 {
                let newTeamMember = TeamMember(context: viewContext)
                
                newTeamMember.timestamp = Date()
                newTeamMember.name = "Member \(teamNum)"
                newProject.addToTeamMembers(newTeamMember)
                
                for taskNum in 0..<3 {
                    let newTask = Task(context: viewContext)
                    
                    newTask.timestamp = Date()
                    newTask.name = "Preview Task"
                    newTeamMember.addToTasks(newTask)
                }
            }

        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ProjectManager")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}


extension PersistenceController {
    
    func save() {
        do {
            try container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
