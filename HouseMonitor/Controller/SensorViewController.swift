//
//  SensorViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/26/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit
import RealmSwift

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

    }
	
	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
	}
	
	//MARK: - TableView Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sensors? .count ?? 1

	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			let cell = tableView.dequeueReusableCell(withIdentifier: "Sensors", for: indexPath)
		cell.textLabel?.text = sensors?[indexPath.row].Name ?? "No Sensor Added Yet"
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
