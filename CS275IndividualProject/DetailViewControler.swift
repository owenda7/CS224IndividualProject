//
//  DetailViewControler.swift
//  CS275IndividualProject
//
//  Created by Owen Anderson on 11/28/20.
//

import UIKit

protocol returnDataToMainView {
    func returnDataFromDetailView(task: Task?)
}

class DetailViewController: UIViewController{
    
    // delegate for returning data
    var delegate: returnDataToMainView? = nil
    
    // task object passed from main view
    var task: Task? = nil
    // text fiels and text view for viewing task data
    @IBOutlet var name: UITextField!
    @IBOutlet var date: UITextField!
    @IBOutlet var desc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // populate variables from task object
        name.text = self.task?.name ?? ""
        date.text = self.task?.date ?? ""
        desc.text = self.task?.desc ?? ""
    }
    
    // exit view and save changes to item
    @IBAction func exitView(_ sender: UIButton){
        // if task and delegate exist, save changes to task object and pass task back to main view
        if self.delegate != nil && self.task != nil{
            self.task?.name = name.text ?? ""
            self.task?.date = date.text ?? ""
            self.task?.desc = desc.text
            self.delegate?.returnDataFromDetailView(task: task)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // exit view and delete the item present
    @IBAction func deleteItem(_ sender: UIButton){
        // pass back nil so item is deleted
        self.delegate?.returnDataFromDetailView(task: nil)
        dismiss(animated: true, completion: nil)
    }
}

