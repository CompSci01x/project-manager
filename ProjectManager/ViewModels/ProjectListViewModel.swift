//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/4/21.
//

import Foundation
import SwiftUI
import CoreData

class ProjectListViewModel: ObservableObject {
 
    private let persistenceController = PersistenceController.shared
    @Published var allProjects: [Project] = []
 
    func getAllItems() {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            allProjects = try persistenceController.container.viewContext.fetch(request)
            allProjects.sort { $0.timestamp! > $1.timestamp! }
        } catch {
            print(error)
        }
    }
    
    func addProject(projectName: String, projectDesc: String, projectCardColor: Color) {
        
        withAnimation {
            let newProject = Project(context: persistenceController.container.viewContext)
            newProject.timestamp = Date()
            newProject.projectName = projectName
            newProject.projectDescription = projectDesc
            
            do {
                try newProject.projectCardColor = NSKeyedArchiver.archivedData(withRootObject: UIColor(projectCardColor),
                                                                        requiringSecureCoding: false)
            } catch {
                print(error)
            }
            
            persistenceController.save()
            getAllItems()
        }
    }
    
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { allProjects[$0] }.forEach(persistenceController.container.viewContext.delete)
        persistenceController.save()
        getAllItems()
    }

}


extension ProjectListViewModel {
    
    static func getAllItemsForPreview() -> [Project] {
        
        let previewController = PersistenceController.preview

        let request: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            var previewProjects = try previewController.container.viewContext.fetch(request)
            previewProjects.sort { $0.timestamp! > $1.timestamp! }
            return previewProjects
        } catch {
            print(error)
        }
        
        return []
    }
    
}

