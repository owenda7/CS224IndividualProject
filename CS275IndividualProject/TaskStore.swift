//
//  TaskStore.swift
//  CS275IndividualProject
//
//  Created by Owen Anderson on 12/1/20.
//

import UIKit

class TaskStore: NSObject{
    var tasks: [Task]
    let datakey = "datakey"
    
    // initializer to load saved data if it exists
    override init(){
        self.tasks = []
        if let encodedData = UserDefaults.standard.data(forKey: datakey){
            if let data = try? JSONDecoder().decode([Task].self, from: encodedData){
                self.tasks = data
            }
        }
    }
    
    // Function to endcode and save data
    func saveData(){
        if let encodedData = try? JSONEncoder().encode(self.tasks){
            UserDefaults.standard.set(encodedData, forKey: datakey)
        }
    }
    
    func addItem(task: Task){
        self.tasks.append(task)
        self.saveData()
    }
    
    func removeItem(index: Int){
        self.tasks.remove(at: index)
        self.saveData()
    }
    
    func getTask(index: Int) -> Task{
        return self.tasks[index]
    }
    func getCount() -> Int{
        return self.tasks.count
    }
}
