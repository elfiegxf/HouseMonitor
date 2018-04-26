//
//  ViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/25/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit

class BRViewController: UITableViewController {
	
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
		cell.textLabel?.text = BRArray[indexPath.row].getName()
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
			let newBR = BorderRouter(IP: AddressField.text!)
		    self.BRArray.append(newBR)
			self.saveBorderRouter()
			self.tableView.reloadData()
		}
			
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Add new address"
			AddressField = alertTextField
		}
			
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	
	func saveBorderRouter(){
		let encoder = PropertyListEncoder()
		do{
			let data = try encoder.encode(self.BRArray)
			try data.write(to: self.dataFilePath!)
		}catch{
			print("Error Encoding Array!, \(error)")
	}
	}
	func loadBorderRouter(){
		if let data = try? Data(contentsOf: dataFilePath!){
			let decoder = PropertyListDecoder()
			do {
				BRArray = try decoder.decode([BorderRouter].self, from: data)
			}catch{
				print("Load Error: \(error)")
			}
		}
	}
}

