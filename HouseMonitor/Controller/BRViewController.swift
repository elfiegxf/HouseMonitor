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
	
	var BRArray = [BorderRouter]()
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
		return BRArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "BorderRouters", for: indexPath)
		cell.textLabel?.text = BRArray[indexPath.row].Name
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
			
		var AddressField = UITextField()
		
		let alert = UIAlertController(title: "Add New BorderRouter", message: "Please Type in the Border Router IPv6 Address and it's name", preferredStyle: .alert)
			
		let action = UIAlertAction(title: "Add item", style: .default){
			(action) in
			// what will happen once the user click the add item button on the UIAlert
			//let newBR = BorderRouter(IP: AddressField.text!)
			let newBR = BorderRouter()
			newBR.Name = AddressField.text!
			self.BRArray.append(newBR)
			self.saveBorderRouter(borderRouter: newBR)
			self.tableView.reloadData()
		}
			
		alert.addTextField{ (alertTextField) in
			alertTextField.placeholder = "Add new address"
			AddressField = alertTextField
		}
			
		alert.addAction(action)
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
//		do{
//			try
//		}
		
	}
}

