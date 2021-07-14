//
//  AddProjectView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/6/21.
//

import SwiftUI

struct AddProjectView: View {

    @Environment(\.presentationMode) var presentationMode
        
    @ObservedObject var projectListVM: ProjectListViewModel
    
    @State private var projectName: String = ""
    @State private var projectDescription: String = ""
    @State private var projectCardColor: Color = Color.random
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Name")) {
                    TextField("Project Name", text: $projectName)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $projectDescription)
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
            presentationMode.wrappedValue.dismiss()
            
        }, trailing: Button("Done") {
            
            if (projectName.isEmpty) {
                showingAlert = true
            } else {
                projectListVM.addProject(projectName: projectName,
                                         projectDescription: projectDescription,
                                         projectCardColor: projectCardColor)
                presentationMode.wrappedValue.dismiss()
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
            AddProjectView(projectListVM: ProjectListViewModel())
        }
    }
}
