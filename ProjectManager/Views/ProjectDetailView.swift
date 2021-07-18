//
//  ProjectDetailView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/10/21.
//

import SwiftUI

struct ProjectDetailView: View {
    
    @StateObject private var projectVM: ProjectViewModel

    init(projectModel: ProjectModel) {
        self._projectVM = StateObject(wrappedValue: ProjectViewModel(projectModel: projectModel))
    }
    
    @State private var isPresented = false
    
    var body: some View {
        
        List {
            
            Section(header: Text("Description")) {
                ScrollView {
                    Text(projectVM.projectDescription)
                        .frame(width: UIScreen.main.bounds.size.width - 75, height: 150, alignment: .topLeading)
                }
            }
            
            Section(header: Text("Color")) {
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(projectVM.projectCardColor)
                }
            }
            
            Section(header: Text("Team Members")) {
//                ForEach {
//                    // team memebers
//                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(projectVM.projectName)
        .navigationBarItems(trailing: Button("Edit") { isPresented.toggle() })
        .fullScreenCover(isPresented: $isPresented, content: {
            NavigationView {
                EditProjectView(projectVM: projectVM)
            }
        })
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    
    static let previewProjects = ProjectListViewModel.getAllProjectsForPreview()
    static var previews: some View {
        NavigationView {
            ProjectDetailView(projectModel: previewProjects[0])
        }
    }
}
