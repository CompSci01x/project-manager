//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/11/21.
//

import Foundation
import CoreData
import SwiftUI

class ProjectViewModel: ObservableObject{
    
    // MARK: - Private vars/lets
    private let persistenceController = PersistenceController.shared
    @Published private var projectModel: ProjectModel
    
    
    // MARK: - Inits
    init() {
        projectModel = ProjectModel()
    }
    
    init(project: Project) {
        self.projectModel = ProjectModel(project: project)
    }
    
    init(projectModel: ProjectModel) {
        self.projectModel = projectModel
    }
      
    
        
    // MARK: - Update and reset
    func update() {
        
        let project = projectModel.getCoreDataProject()
        
        if project != nil {
            project!.projectName = projectName
            project!.projectDescription = projectDescription
            
            do {
                project!.projectCardColor = try NSKeyedArchiver.archivedData(
                    withRootObject: UIColor(projectCardColor),
                    requiringSecureCoding: false)
            } catch {
                print(error)
            }
            
        } else {
            print("Could not find project with id = \(projectModel.id)")
        }
        
        persistenceController.save()
        print("saved = \(projectName)")
    }
    
    
    func reset() {
        let project = projectModel.getCoreDataProject()
        
        if project != nil {
            self.projectModel = ProjectModel(project: project!)
        } else {
            print("Could not find project with id = \(projectModel.id)")
        }
    }
    
    
    // MARK: - Getters and Setters
    var id: UUID {
        return projectModel.id
    }
    
    var timestamp: Date {
        get {
            return projectModel.timestamp
        }
        set {
            projectModel.timestamp = newValue
        }
    }
    
    var projectName: String {
        get {
            return projectModel.projectName
        }
        set {
            projectModel.projectName = newValue
        }
    }
    
    var projectDescription: String {
        get {
            return projectModel.projectDescription
        }
        set {
            projectModel.projectDescription = newValue
        }
    }
    
    var projectCardColor: Color {
        get {
            return projectModel.projectCardColor
        }
        set {
            projectModel.projectCardColor = newValue
        }
    }
    
}
