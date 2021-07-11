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
            ForEach(projectListVM.allProjects) { prj in
                NavigationLink(destination: Text("Destination")) {
                    ProjectCardView(project: prj)
                }
                .listRowBackground(prj.getColor())
            }
            .onDelete(perform: projectListVM.deleteItems)
        }
        .navigationTitle("Projects List")
        .navigationBarItems(trailing: Button(action: { isPresented.toggle() }) {
            Image(systemName: "plus")
        })
        .onAppear(perform: {
            projectListVM.getAllItems()
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                AddProjectView(projectListVM: projectListVM, isPresented: $isPresented)
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
