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
    
    var tasks = [
        Task(name: "CS275 Homework",date: "11/14",desc: "Deliverable 2"),
        Task(name: "CS224 Homework",date: "11/18",desc: "Homework 10 Programming"),
        Task(name: "CS292 Homework",date: "11/24",desc: "Reflection")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension ViewController: UITableViewDelegate, returnDataToMainView{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.task = tasks[indexPath.row]
        tasks.remove(at: indexPath.row)
        performSegue(withIdentifier: "taskSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! DetailViewController
        dest.task = self.task
        dest.delegate = self
    }
    func returnDataFromDetailView(task: Task?){
        if task != nil {
            tasks.append(task ?? Task(name: "", date: "", desc: ""))
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    // generate rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.detailTextLabel?.text = tasks[indexPath.row].date
        return cell
    }
    
    // Add blank row
    @IBAction func addRow(_ sender: UIButton){
        tasks.append(Task(name: "New Task",date: "0/0",desc: ""))
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
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        }
    }
    
    
}
    
