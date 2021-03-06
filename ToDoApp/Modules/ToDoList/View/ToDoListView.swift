//
//  ToDoListView.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import UIKit
import CoreUIKit

class ToDoListView: UIViewController, BaseInitializableView, ToDoListViewProvider {
    
    // MARK: - Properties
    let todoTableView = BaseTableView()
    let addToDoButtonView = UIBarButtonItem()
    private(set) var viewModel: ToDoListViewModel?
    
    // MARK: - Init
    required init(viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ToDo List"
        self.navigationItem.backButtonTitle = ""
        
        self.setupViews()
        self.setupData()
    }
    
    // MARK: - Setups
    func setupViews() {
        self.setupTodoTableView()
        self.setupAddTodoButtonView()
        
        self.viewModel?.onToDoListUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.todoTableView.reloadData()
            }
        }
    }
    
    func setupData() {
        self.viewModel?.initializeData()
    }
    
    func setupTodoTableView() {
        self.todoTableView
            .add(to: self.view)
            .allAnchorsSame(on: self.view)
        
        self.todoTableView
            .register(ToDoItemCell.self)
        
        self.todoTableView.dataSource = self
        self.todoTableView.delegate = self
    }
    
    func setupAddTodoButtonView() {
        self.addToDoButtonView.title = "Add"
        self.addToDoButtonView.target = self
        self.addToDoButtonView.action = #selector(self.didTapAddToDoButtonView)
        self.addToDoButtonView.style = .plain
        
        self.navigationItem.rightBarButtonItem = self.addToDoButtonView
    }
    
}

// MARK: - Action Handlers
extension ToDoListView {
    
    @objc func didTapAddToDoButtonView() {
        let addToDoView = AddToDoView(viewModel: AddToDoViewModel(todoStorageHelper: self.viewModel!.todoStorageHelper))
        addToDoView.onNewToDoSave = { [weak self] newToDoItem in
            self?.viewModel?.didAddNew(toDoItem: newToDoItem)
        }
        
        self.navigationController?
            .pushViewController(addToDoView, animated: true)
    }
    
}
