//
//  CreateToDo.swift
//  ToDo
//
//  Created by Jaylen Scott on 11/5/21.
//

import SwiftUI

struct CreateToDo: View {
    
    @State var toDoTitle = ""
    @State var important = false
    @State var reminder = false
    @State private var date = Date()    // Sets date
    @State private var loi = LOI.low    // Sets level of importance
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var toDoStorage: ToDoStorage
    
    // Not sure if this should stay here
    enum LOI: String, CaseIterable, Identifiable {
        case low
        case moderate
        case high
        
        var id: String { self.rawValue }
    }
    
    
    var body: some View {
        List {
            Section {
                TextField("Ex. Walk the dog", text: $toDoTitle)
            }
            Section {
                // Toggle for important Bool
                Toggle(isOn:$important) {
                    Text("Important")
                }
                
                if important == true {
                    // Picker for level of importance
                    Picker("Importance Level", selection: $loi) {
                        Text("low").tag(LOI.low)
                        Text("moderate").tag(LOI.moderate)
                        Text("high").tag(LOI.high)
                    }
                }
            }
            Section {
                // Reminders based on time user selects
                DatePicker(
                    "Reminder Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                
            }
            Section {
                HStack {
                    Spacer()
                    Button("Save") {
                        // Pulls ToDo item into stored list
                        self.toDoStorage.toDos.append(ToDoItem(title: self.toDoTitle, important: self.important, reminder: self.reminder))
                        
                        // This moves the user back to the previous view
                        self.presentationMode.wrappedValue.dismiss()
                    }.disabled(toDoTitle.isEmpty) // This disables button if to do is empty
                    Spacer()
                }
            }
        }.listStyle(GroupedListStyle()) // This sets general styling of the list
        
    }
    
}

//struct Picker<Label, SelectionValue, Content> where Label : View, SelectionValue : Hashable, Content : View {
// Not really sure what or if this goes here
//}

struct CreateToDo_Previews: PreviewProvider {
    static var previews: some View {
        CreateToDo().environmentObject(ToDoStorage())
    }
}
