//
//  ViewController.swift
//  CS275IndividualProject
//
//  Created by Owen Anderson on 11/14/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
        
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tasks[indexPath.row].desc)
    }
}

extension ViewController: UITableViewDataSource {
    // generate rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.detailTextLabel?.text = tasks[indexPath.row].date
        return cell
    }
    
    // Add blank row
    @IBAction func addRow(_ sender: UIButton){
        tasks.append(Task(name: "New Task",date: "",desc: ""))
        tableView.reloadData()
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
    
