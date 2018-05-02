//
//  SensorViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/26/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class SensorViewController: UITableViewController {
	
	let realm = try! Realm()
	//var SensorArray: Results<Sensor>?
	var sensors : List<Sensor>?
	//selected BorderRouter from previous view
	var selectedBR : BorderRouter?{
		didSet{
			loadSensors()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = 60.0
		loadSensors()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
	}
	
	//MARK: - TableView Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sensors? .count ?? 1

	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
		UITableViewCell {
			let cell = tableView.dequeueReusableCell(withIdentifier: "Sensors", for: indexPath) as! SwipeTableViewCell
			cell.textLabel?.text = sensors?[indexPath.row].Name ?? "No Sensor Added Yet"
			cell.delegate = self
			return cell
	}

	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToData", sender: self)
		print("You selected cell #\(indexPath.row)!")
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToData"{
			let destinationVC = segue.destination as! DataViewController
			
			if let indexPath = tableView.indexPathForSelectedRow{
				destinationVC.selectedSensor = (sensors?[indexPath.row])!
			}
			
		}
		
	}
	//MARK: - Data Manipulation Methods
	func loadSensors(){
		sensors = selectedBR?.sensors
		tableView.reloadData()
	}
}

extension SensorViewController: SwipeTableViewCellDelegate{
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }
		
		let deleteAction = SwipeAction(style: .destructive, title: "Delete"){ action, indexPath in
			// handle action by updating model with deletion
			if let deletedBR = self.sensors?[indexPath.row]{
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
