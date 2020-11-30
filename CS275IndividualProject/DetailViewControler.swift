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
    
    var task: Task? = nil
    @IBOutlet var name: UITextField!
    @IBOutlet var date: UITextField!
    @IBOutlet var desc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = self.task?.name ?? ""
        date.text = self.task?.date ?? ""
        desc.text = self.task?.desc ?? ""
    }
    
    @IBAction func exitView(_ sender: UIButton){
        
        if self.delegate != nil && self.task != nil{
            self.task?.name = name.text ?? ""
            self.task?.date = date.text ?? ""
            self.task?.desc = desc.text
            self.delegate?.returnDataFromDetailView(task: task)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteItem(_ sender: UIButton){
        
        self.delegate?.returnDataFromDetailView(task: nil)
        dismiss(animated: true, completion: nil)
    }
}

