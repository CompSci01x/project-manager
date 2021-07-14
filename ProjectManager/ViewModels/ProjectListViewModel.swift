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
    @Published var allProjects: [ProjectViewModel] = []
 
    func getAllProjects() {
        do {
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            allProjects = try persistenceController.container.viewContext.fetch(request).map(ProjectViewModel.init)
            allProjects.sort { $0.timestamp > $1.timestamp }
        } catch {
            print(error)
        }
    }
    
    func addProject(projectName: String, projectDescription: String, projectCardColor: Color) {
        
        withAnimation {
            let newProject = Project(context: persistenceController.container.viewContext)

            newProject.timestamp = Date()
            newProject.projectName = projectName
            newProject.projectDescription = projectDescription
            
            do {
                try newProject.projectCardColor = NSKeyedArchiver.archivedData(withRootObject: UIColor(projectCardColor),
                                                                        requiringSecureCoding: false)
            } catch {
                print(error)
            }
            
            persistenceController.save()
            getAllProjects()
        }
    }
    
    
    func deleteProject(offsets: IndexSet) {
        
        offsets.map { allProjects[$0] }.forEach { projectVM in
            projectVM.deleteProject()
        }
        getAllProjects()
    }

}


extension ProjectListViewModel {
    
    static func getAllItemsForPreview() -> [ProjectViewModel] {
        
        let previewController = PersistenceController.preview

        let request: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            var previewProjects = try previewController.container.viewContext.fetch(request).map(ProjectViewModel.init)
            previewProjects.sort { $0.timestamp > $1.timestamp }
            return previewProjects
        } catch {
            print(error)
        }
        
        return []
    }
    
}

