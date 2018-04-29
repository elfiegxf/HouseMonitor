//
//  LeftViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/27/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit

class LeftViewController: UITableViewController {

	
	let tableViewCellTitle = [
		"Message Us",
		"About"
	]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	// MARK: - TableView DataSource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewCellTitle.count
	}
	

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
		cell.textLabel?.text = tableViewCellTitle[indexPath.row]
		return cell
	}
	
	// MARK: - TableView Delegate
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
			case 0:
			  //Mail pods update needed
				tableView.reloadData()
			case 1:
				performSegue(withIdentifier: "showAbout", sender: self)
		default:
			break
		}
	}
	
	
}
