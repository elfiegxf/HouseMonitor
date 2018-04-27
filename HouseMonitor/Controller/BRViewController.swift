//
//  ViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/25/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit
import RealmSwift


class BRViewController: UITableViewController {
	
	let realm = try! Realm()
	var BRArray: Results<BorderRouter>?
	
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("BorderRouter.plist")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadBorderRouter()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	//Mark - TableView Datasource Method
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return BRArray?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "BorderRouters", for: indexPath)
		cell.textLabel?.text = BRArray?[indexPath.row].Name ?? "No BorderRouter Added Yet"
		return cell
	}
	//Mark - TableView Delegate Methods
	// click cell and get content printed
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.accessoryType = .disclosureIndicator
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//Mark - Table Add Border Router button
	
	
		@IBAction func AddBR(_ sender: Any) {
			
		var NameField = UITextField()
		var AddressField = UITextField()
			
		let alert = UIAlertController(title: "Add New BorderRouter", message: "Please Type in the Border Router IPv6 Address and it's name", preferredStyle: UIAlertControllerStyle.alert)
			alert.addTextField { (textField : UITextField!) -> Void in
				textField.placeholder = "Enter New Name"
			}
			
		let addAction = UIAlertAction(title: "Add", style: .default){
			(action) in
			// what will happen once the user click the add item button on the UIAlert
			//let newBR = BorderRouter(IP: AddressField.text!)
			let newBR = BorderRouter()
			newBR.Name = NameField.text!
			newBR.IP = AddressField.text!
			self.saveBorderRouter(borderRouter: newBR)
			self.tableView.reloadData()
		}
		

		alert.addTextField{ (alertTextField) in
			alertTextField.placeholder = "Enter New Address"
			NameField = alert.textFields![0] as UITextField
			AddressField = alert.textFields![1] as UITextField
		}
			
		alert.addAction(addAction)
			alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	
	func saveBorderRouter(borderRouter: BorderRouter){
		do{
			try realm.write {
				realm.add(borderRouter)
			}
		} catch{
			print( "Error saving borderRouter\(error)")
		}
	}
	func loadBorderRouter(){
		let loadArray = realm.objects(BorderRouter.self)
		BRArray = loadArray
		tableView.reloadData()
	}
}

