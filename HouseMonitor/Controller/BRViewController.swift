//
//  ViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/25/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit
import RealmSwift
import SideMenu
import SwipeCellKit

class BRViewController: UITableViewController{
	
	let realm = try! Realm()
	var borderRouters: Results<BorderRouter>?
	open var menuAnimationOptions: UIViewAnimationOptions = .curveEaseInOut
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = 60.0
		loadBorderRouter()
		
	}
	
	//MARK: - TableView Datasource Method
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return borderRouters?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BorderRouters", for: indexPath) as! SwipeTableViewCell
		cell.textLabel?.text = borderRouters?[indexPath.row].Name ?? "No BorderRouter Added Yet"
		cell.delegate = self
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "goToSensors", sender: self)
		print("You selected cell #\(indexPath.row)!")
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToSensors"{
			let destinationVC = segue.destination as! SensorViewController
		
			if let indexPath = tableView.indexPathForSelectedRow{
			destinationVC.selectedBR = (borderRouters?[indexPath.row])!
			}
		}
		
	}

	//MARK: - Side Menu Action
	@IBAction func toggleEditing(_ sender: Any) {
	present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
		dismiss(animated: true, completion: nil)
		
		
	}
	
	
	//MARK: - Data Manipulate Methods
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
			var newBR = BorderRouter()
			newBR.Name = NameField.text!
			newBR.IP = AddressField.text!
			newBR = self.AddDummyData(newBR)
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
	
	//MARK : Helper functions
	func AddDummyData(_ BR : BorderRouter) -> BorderRouter{
		let s0 = Sensor()
		s0.Name = "this"
		s0.IP = "fe80::1ff:fe23:4567:890a"
		let s1 = Sensor()
		s1.Name = "is"
		s1.IP = "fe80::1ff:fe23:4567:890a"
		let s2 = Sensor()
		s2.Name = "a"
		s2.IP = "fe80::1ff:fe23:4567:890a"
		let s3 = Sensor()
		s3.Name = "test"
		s3.IP = "fe80::1ff:fe23:4567:890a"
		BR.sensors.append(s0)
		BR.sensors.append(s1)
		BR.sensors.append(s2)
		BR.sensors.append(s3)
		return BR
	}
	// function - Save items to database
	
	func saveBorderRouter(borderRouter: BorderRouter){
		do{
			try realm.write {
				realm.add(borderRouter)
			}
		} catch{
			print( "Error saving borderRouter\(error)")
		}
	}
	//function - Load items from database
	func loadBorderRouter(){
		let loadArray = realm.objects(BorderRouter.self)
		borderRouters = loadArray
		tableView.reloadData()
	}
}

//MARK: - Search bar methods
extension BRViewController: UISearchBarDelegate{
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
			borderRouters = borderRouters?.filter("Name CONTAINS[cd] %@", searchBar.text!)
		tableView.reloadData()
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
		if searchBar.text? .count == 0{
			loadBorderRouter()
			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}
		}
	}
	
}

extension BRViewController: SwipeTableViewCellDelegate{
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }
		
		let deleteAction = SwipeAction(style: .destructive, title: "Delete"){ action, indexPath in
			// handle action by updating model with deletion
			if let deletedBR = self.borderRouters?[indexPath.row]{
				do {
					try self.realm.write {
						self.realm.delete(deletedBR)
						tableView.reloadData()
					}
				} catch {
					print("Error Deleting Item, \(error)")
				}
			}
		
	}
		
		// customize the action appearance
		deleteAction.image = UIImage(named: "Delete")
		
		return [deleteAction]
	}
}

