//
//  models.swift
//  number3
//
//  Created by afnan saad on 19/01/1445 AH.
//

import Foundation
struct Status: Identifiable {
    let id = UUID()
      var dosome: String
      var backlog = false
     var todo = false
      var done = false
     var inProgrees = false
    
}

class Details: ObservableObject {
    @Published var details = [Status]()
    func getTasksCount() -> Int {
        return details.count
    }
    }
