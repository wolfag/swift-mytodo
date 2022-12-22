//
//  TaskRow.swift
//  MyTodo
//
//  Created by TaiNguyen on 22/12/2022.
//

import SwiftUI

struct TaskRow: View {
    var color: Color
    var isDone: Bool
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: isDone ? "checkmark.square" : "square")
                    .foregroundColor(color)
                
                Text(title)
                    .foregroundColor(color)
                    .strikethrough(isDone, color: .black)
            }
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(color: Color.orange, isDone: true, title: "title") {
            
        }
    }
}
