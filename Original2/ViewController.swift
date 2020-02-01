//
//  ViewController.swift
//  Original2
//
//  Created by 張丹 on 2019/12/14.
//  Copyright © 2019 張丹. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    var itemList: Results<TodoModel>!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let RealmInstance1 = try! Realm()
        
        self.itemList = RealmInstance1.objects(TodoModel.self)
    }
    
    @IBAction func add(_ sender: Any) {
        
        let instanceTodoModel:TodoModel = TodoModel()
        
        instanceTodoModel.mochimonoteiji = self.textField.text
        
        let RealmInstance2 = try! Realm()
        
        
        try! RealmInstance2.write {
            RealmInstance2.add(instanceTodoModel)
        }
        
        self.table.reloadData()
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        
        let item: TodoModel = self.itemList[(indexPath as NSIndexPath).row];
        
        cell.textLabel?.text = item.mochimonoteiji
        
        return cell
    }
    
    //セルの編集許可
       func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
       {
           return true
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            itemList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            
            
        }
    }


}



