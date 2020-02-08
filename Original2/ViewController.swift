//
//  ViewController.swift
//  Original2
//
//  Created by 張丹 on 2019/12/14.
//  Copyright © 2019 張丹. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    var itemList: Results<TodoModel>!
    var item: TodoModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        
        do{
            let realm = try Realm()
            itemList = realm.objects(TodoModel.self)
            table.reloadData()
        }catch{
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

          return self.itemList.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
          
          item = self.itemList[(indexPath as NSIndexPath).row];
          
          cell.textLabel?.text = item.mochimonoteiji
          
          return cell
      }
    
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
          
          if (editingStyle == UITableViewCell.EditingStyle.delete) {
              do{
                  let realm = try Realm()
                  try realm.write {
                      realm.delete(self.itemList[indexPath.row])
                  }
                  table.deleteRows(at: [(indexPath as IndexPath)], with: UITableView.RowAnimation.fade)
              }catch{
                
              }
            self.table.reloadData()
          }
    }
}
    

