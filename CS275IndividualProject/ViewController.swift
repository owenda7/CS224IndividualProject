//
//  ViewController.swift
//  CS275IndividualProject
//
//  Created by Owen Anderson on 11/14/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    // blank task for passing to display view
    var task = Task(name: "", date: "", desc: "")
    // initialize taskStore
    var taskStore = TaskStore.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
}

// extensions of View Controller class for swiching between views
extension ViewController: UITableViewDelegate, returnDataToMainView{
    // runs when item selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get selected task
        self.task = taskStore.getTask(index: indexPath.row)
        // remove it from store to pass
        taskStore.removeItem(index: indexPath.row)
        // switch views and run prepare functon
        performSegue(withIdentifier: "taskSegue", sender: self)
    }
    // prepares data before switching views
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass data to display view
        let dest = segue.destination as! DetailViewController
        dest.task = self.task
        dest.delegate = self
    }
    // runs when returning from detail view
    func returnDataFromDetailView(task: Task?){
        // if task is returned, add it back to store and reload main view
        if task != nil {
            taskStore.addItem(task: task ?? Task(name: "", date: "", desc: ""))
        }
        tableView.reloadData()
    }
}

//
extension ViewController: UITableViewDataSource {
    // add number of rows to view as in store
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.getCount()
    }
    // populatre rows with data from corresponding task in store
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = taskStore.getTask(index: indexPath.row).name
        cell.detailTextLabel?.text = taskStore.getTask(index: indexPath.row).date
        return cell
    }
    
    // Function to add new blank task to store and reload view to display
    @IBAction func addRow(_ sender: UIButton){
        self.task = Task(name: "New Task",date: "01/01",desc: "Add description here...")
        performSegue(withIdentifier: "taskSegue", sender: self)
    }
    
    // Functions to delete row
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            taskStore.removeItem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
}
    
