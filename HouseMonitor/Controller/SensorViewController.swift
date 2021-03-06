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
	var SensorArray: Results<Sensor>?
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
	}
	
	//MARK: - TableView Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return SensorArray? .count ?? 1
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			let cell = tableView.dequeueReusableCell(withIdentifier: "Sensors", for: indexPath)
			cell.textLabel?.text = SensorArray?[indexPath.row].Name ?? "No Sensor Added Yet"
		return cell
	}

	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	//MARK: - Data Manipulation Methods
	
}
