//
//  TaskStore.swift
//  CS275IndividualProject
//
//  Created by Owen Anderson on 12/1/20.
//

import UIKit

// Class for storing array of task objects and saving data between app sessions
class TaskStore: NSObject{
    var tasks: [Task]
    let datakey = "datakey" // key for saving data
    
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
    // add item to store
    func addItem(task: Task){
        self.tasks.append(task)
        self.saveData()
    }
    // remove item from store
    func removeItem(index: Int){
        self.tasks.remove(at: index)
        self.saveData()
    }
    // get task from store (does NOT remove)
    func getTask(index: Int) -> Task{
        return self.tasks[index]
    }
    // get number of task items in store
    func getCount() -> Int{
        return self.tasks.count
    }
}
