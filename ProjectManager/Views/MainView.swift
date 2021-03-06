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
            ForEach(projectListVM.allProjects, id: \.id) { projectVM in
                NavigationLink(destination: ProjectDetailView(projectVM: projectVM)) {
                    ProjectCardView(projectVM:projectVM)
                }
                .listRowBackground(projectVM.projectCardColor)
            }
            .onDelete(perform: { indexSet in
                projectListVM.deleteProject(offsets: indexSet)
            })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Projects")
        .navigationBarItems(trailing: Button(action: { isPresented.toggle() }) {
            Image(systemName: "plus")
        })
        .onAppear(perform: {
            projectListVM.getAllProjects()
        })
        .sheet(isPresented: $isPresented,
               content: {
                NavigationView {
                    AddProjectView(projectListVM: projectListVM)
                }
                .onDisappear(perform: {
                    projectListVM.refresh()
                })
       })
        
        
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
