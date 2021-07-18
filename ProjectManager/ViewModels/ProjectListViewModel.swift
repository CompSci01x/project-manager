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
    @Published var allProjects: [ProjectModel] = []
 
    func getAllProjects() {
        do {
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            allProjects = try persistenceController.container.viewContext.fetch(request).map(ProjectModel.init)
            allProjects.sort { $0.timestamp > $1.timestamp }
        } catch {
            print(error)
        }
    }
    
    func addNewProject(projectVM: ProjectViewModel) {

        let newProject = Project(context: persistenceController.container.viewContext)
        
        newProject.projectId = UUID()
        newProject.timestamp = Date()
        newProject.projectName = projectVM.projectName
        newProject.projectDescription = projectVM.projectDescription
       
        do {
            newProject.projectCardColor = try NSKeyedArchiver.archivedData(
                withRootObject: UIColor(projectVM.projectCardColor),
                requiringSecureCoding: false)
        } catch {
            print(error)
        }
        
        persistenceController.save()
        getAllProjects()
    }
    
    func deleteProject(offsets: IndexSet) {
        
        offsets.map { allProjects[$0] }.forEach { projectModel in
            
            let project = projectModel.getCoreDataProject()
            if project != nil {
                persistenceController.container.viewContext.delete(project!)
            } else {
                print("Could not find project with id = \(projectModel.id)")
            }
        }
        persistenceController.save()
        getAllProjects()
    }

}


extension ProjectListViewModel {

    static func getAllProjectsForPreview() -> [ProjectModel] {

        let previewController = PersistenceController.preview

        let request: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            var previewProjects = try previewController.container.viewContext.fetch(request).map(ProjectModel.init)
            previewProjects.sort { $0.timestamp > $1.timestamp }
            return previewProjects
        } catch {
            print(error)
        }

        return []
    }

}

