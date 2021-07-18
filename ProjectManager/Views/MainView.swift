//
//  ContentView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/4/21.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @StateObject private var projectListVM = ProjectListViewModel()
    @State private var isPresented = false

    var body: some View {
        List {
            ForEach(projectListVM.allProjects, id: \.id) { projectModel in
                NavigationLink(destination:
                                ProjectDetailView(projectModel: projectModel)) {
                    ProjectCardView(projectModel: projectModel )
                }
                .listRowBackground(projectModel.projectCardColor)
            }
            .onDelete(perform: projectListVM.deleteProject)
        }
        .navigationTitle("Projects List")
        .navigationBarItems(trailing: Button(action: { isPresented.toggle() }) {
            Image(systemName: "plus")
        })
        .onAppear(perform: {
            projectListVM.getAllProjects()
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                AddProjectView(projectListVM: projectListVM)
            }
        }
        
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
