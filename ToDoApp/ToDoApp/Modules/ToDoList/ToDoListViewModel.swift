//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

struct ToDoListViewModel: BaseViewModel, ToDoListDataProvider {
    
    var todos = [ToDoItem]()
    
    func initializeData() {
        
    }
    
}
