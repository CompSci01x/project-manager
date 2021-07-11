//
//  AddProjectView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/6/21.
//

import SwiftUI

struct AddProjectView: View {
    
    @ObservedObject var projectListVM: ProjectListViewModel
    @Binding var isPresented: Bool
    
    @State private var projectName: String = ""
    @State private var projectDesc: String = ""
    @State private var projectCardColor: Color = Color.green
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Name")) {
                    TextField("Project Name", text: $projectName)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $projectDesc)
                        .frame(width: UIScreen.main.bounds.width - 75, height: 150, alignment: .topLeading)
                }
                
                Section(header: Text("Color")) {
                    ColorPicker("Card Color", selection: $projectCardColor)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Add Project")
        .navigationBarItems(leading: Button("Cancel") {
            isPresented = false

        }, trailing: Button("Done") {
            
            if (projectName.isEmpty) {
                showingAlert = true
            } else {
                projectListVM.addProject(projectName: projectName, projectDesc: projectDesc, projectCardColor: projectCardColor)
                isPresented = false
            }
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Project Name Required"), message: Text("Project requires a name."), dismissButton: .default(Text("Ok")))
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            AddProjectView(projectListVM: ProjectListViewModel(), isPresented: .constant(true))
        }
    }
}
