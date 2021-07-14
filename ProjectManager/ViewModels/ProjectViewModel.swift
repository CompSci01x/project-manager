//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/11/21.
//

import Foundation
import CoreData
import SwiftUI

struct ProjectViewModel {
    
    // MARK: - Private vars/lets
    
    private let persistenceController = PersistenceController.shared
    private let project: Project
    
    // MARK: - Init
    
    init(project: Project) {
        self.project = project
    }
    
    
    // MARK: - Getters and Setters
    
    var id: NSManagedObjectID {
        return project.objectID
    }
    
    var timestamp: Date {
        get {
            return project.timestamp!
        }
        set {
            project.timestamp = newValue
        }
    }
    
    var projectName: String {
        get {
            return project.projectName ?? "Unknown Project Name"
        }
        set {
            project.projectName = newValue
        }
    }
    
    var projectDescription: String {
        get {
            return project.projectDescription ?? "No Description"
        }
        set {
            project.projectDescription = newValue
        }
    }
    
    var projectCardColor: Color {
        get {
            if (project.projectCardColor != nil) {
                do {
                    return try Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: project.projectCardColor!)!)
                } catch {
                    print(error)
                }
            }
            return Color.clear
        }
        set {
            do {
                try project.projectCardColor = NSKeyedArchiver.archivedData(withRootObject: UIColor(newValue),
                                                                        requiringSecureCoding: false)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - CoreData Delete
    
    func deleteProject() {
        persistenceController.container.viewContext.delete(project)
        persistenceController.save()
    }
    
}
