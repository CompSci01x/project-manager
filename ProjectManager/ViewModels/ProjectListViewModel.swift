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
    
    func refresh() {
        persistenceController.container.viewContext.rollback()
    }
    
    func addNewProject(projectVM: ProjectViewModel) {
        
        projectVM.timestamp = Date()
        
        persistenceController.save()
        getAllProjects()
    }
    
    func deleteProject(offsets: IndexSet) {

        offsets.forEach { idx in
            allProjects[idx].deleteProject()
        }
        
        persistenceController.save()
        getAllProjects()
    }

}


extension ProjectListViewModel {

    static func getAllProjectsForPreview() -> [ProjectViewModel] {

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

