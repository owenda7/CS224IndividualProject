//
//  ViewController.swift
//  CS275IndividualProject
//
//  Created by Owen Anderson on 11/14/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var task = Task(name: "", date: "", desc: "")
    var taskStore = TaskStore.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension ViewController: UITableViewDelegate, returnDataToMainView{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.task = taskStore.getTask(index: indexPath.row)
        taskStore.removeItem(index: indexPath.row)
        performSegue(withIdentifier: "taskSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! DetailViewController
        dest.task = self.task
        dest.delegate = self
    }
    func returnDataFromDetailView(task: Task?){
        if task != nil {
            taskStore.addItem(task: task ?? Task(name: "", date: "", desc: ""))
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    // generate rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.getCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = taskStore.getTask(index: indexPath.row).name
        cell.detailTextLabel?.text = taskStore.getTask(index: indexPath.row).date
        return cell
    }
    
    // Add blank row
    @IBAction func addRow(_ sender: UIButton){
        taskStore.addItem(task: Task(name: "New Task",date: "0/0",desc: ""))
        tableView.reloadData()
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    // Swipe delete row
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
    
