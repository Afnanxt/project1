//
//  ContentView.swift
//  number3
//
//  Created by afnan saad on 19/01/1445 AH.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var detail = Details()
    @ObservedObject var todo = ListViewModle()
    @State var search: String = ""
    @State var showBacklog = false
    @State var showToDo = false
    @State var showDone = false
    @State var showInProgrees = false
    var body: some View {
        
        NavigationStack {
            VStack {
                
                HStack {
                    TextField("Enter in a new task", text: self.$search)
                    Button(action: {
                        toAdd()
                    }, label: { Text("Add") })
                }
                
                
                .padding()
                Form {
                    Section {
                        if detail.getTasksCount() == 0 {
                            Text(" ")
                            
                                .font(.headline)
                                .foregroundColor(.gray.opacity(0.2))
                            Text(" no tasks ")
                            
                                .padding()
                        } else {
                            List {
                                // To set value in list
                                ForEach(detail.details.filter { !$0.todo && !$0.done && !$0.backlog && !$0.inProgrees }) { i in
                                    Text(i.dosome)
                                    
                                        .contextMenu {
                                            Button(action: {
                                                // Done the item
                                                if let index = detail.details.firstIndex(where: { $0.id == i.id }) {
                                                    detail.details[index].inProgrees = true
                                                }
                                            }) {
                                                Label("IN PROGREES", systemImage: " lanyardcard")
                                            }
                                            
                                            
                                            Button(action: {
                                                // Done the item
                                                if let index = detail.details.firstIndex(where: { $0.id == i.id }) {
                                                    detail.details[index].done = true
                                                }
                                            }) {
                                                Label("Done", systemImage: " person.fill.checkmark")
                                            }
                                            
                                            // Flag the item
                                            Button(action: {
                                                if let index = detail.details.firstIndex(where: { $0.id == i.id }) { detail.details[index].todo = true}}){
                                                    Label("todo", systemImage: " person.fill.checkmark")
                                                }
                                            
                                            
                                            Button(action: {
                                                // Mark the item as Baklog
                                                if let index = detail.details.firstIndex(where: { $0.id == i.id }) {
                                                    detail.details[index].backlog = true
                                                }
                                            }) {
                                                Label("Backlog", systemImage: "checkmark")
                                            }
                                        }
                                }
                                .onMove(perform: self.move)
                                .onDelete(perform: self.delete)
                                
                            }
                        }
                        
                        
                        if showToDo {
                            Section(header: Text("list")) {
                                List {
                                    ForEach(detail.details.filter { $0.todo }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                        
                        if showBacklog {
                            Section(header: Text("backlog")) {
                                List {
                                    ForEach(detail.details.filter { $0.backlog }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                        if showInProgrees {
                            Section(header: Text("IN PROGREES")) {
                                List {
                                    ForEach(detail.details.filter { $0.inProgrees }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                        if showDone {
                            Section(header: Text("Done")) {
                                List {
                                    ForEach(detail.details.filter { $0.done }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                    }
                }
                
                .navigationBarTitle("To Do")
                .navigationBarItems(leading:EditButton())
                
                HStack {
                    Button(action: {
                        showBacklog = false
                        showInProgrees = true
                        showToDo = false
                        showDone = false
                    }, label: { Text("in progrees")
                            .bold()
                            .font(.system(size: 19))
                    })
                    .padding()
                    Button(action: {
                        showBacklog = true
                        showInProgrees = false
                        showToDo = false
                        showDone = false
                    }, label: { Text("backloog")
                            .bold()
                            .font(.system(size: 19))
                    })
                    Button(action: {
                        showBacklog = false
                        showInProgrees = false
                        showToDo = true
                        showDone = false
                    }, label: { Text("to do")
                            .bold()
                            .font(.system(size: 19))
                    })
                    .padding()
                    
                    
                    Button(action: {
                        showBacklog = false
                        showInProgrees = false
                        showToDo = false
                        showDone = true
                    }, label: { Text("done")
                            .bold()
                            .font(.system(size: 19))
                    })
                }
            }
        }
    }
    func toAdd() {
        if !search.isEmpty {
            detail.details.append(Status(dosome: search))
            search = ""
        }
    }
    func move(from source: IndexSet, to destination: Int) {
        detail.details.move(fromOffsets: source, toOffset: destination)
    }
    func delete(at offsets: IndexSet) {
        detail.details.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
