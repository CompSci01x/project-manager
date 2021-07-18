//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/17/21.
//

import Foundation
import SwiftUI
import CoreData

struct ProjectModel: Identifiable {
    
    private var persistenceController = PersistenceController.shared
    
    var id: UUID
    var timestamp: Date
    var projectName: String
    var projectDescription: String
    var projectCardColor: Color
    
    init() {
        self.id = UUID()
        self.timestamp = Date()
        self.projectName = ""
        self.projectDescription = ""
        self.projectCardColor = Color.random
    }
    
    init(project: Project) {
        self.id = project.projectId ?? UUID()
        self.timestamp = project.timestamp ?? Date()
        self.projectName = project.projectName ?? ""
        self.projectDescription = project.projectDescription ?? ""
        
        do {
            try self.projectCardColor = Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: project.projectCardColor!)!)
        } catch {
            print(error)
            self.projectCardColor = Color.clear
        }
    }
    
    func getCoreDataProject() -> Project? {
        
        do {
            let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "projectId == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1
            
            return try persistenceController.container.viewContext.fetch(fetchRequest).first ?? nil

        } catch {
            print(error)
        }

        return nil
    }
    
}
