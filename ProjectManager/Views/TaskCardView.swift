//
//  TaskCardView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/19/21.
//

import SwiftUI

struct TaskCardView: View {
    
    var taskVM: TaskViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(taskVM.name)")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            HStack {
                Text("\(taskVM.taskDescription)")
            }
            .font(.subheadline)
        }
        .padding()
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(taskVM: TaskViewModel())
            .previewLayout(.fixed(width: 400, height: 160))
    }
}
