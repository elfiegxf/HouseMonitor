//
//  DataViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/27/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class DataViewController: UIViewController {
	
	
	@IBOutlet weak var sensor: UILabel!
	
	@IBOutlet weak var temper: UILabel!
	
	@IBOutlet weak var humid: UILabel!
	
	@IBOutlet weak var lumino: UILabel!
	
//	let dummyData = [ arc4random_uniform(80),
//	 arc4random_uniform(60),
//	 arc4random_uniform(180)]
	//MARK: - Properties
	let realm = try! Realm()
	var data: List<Data>?
	var selectedSensor: Sensor? {
		didSet{
			//loadData()
			
		}
	}
	
	//MARK:- View life cycle
    override func viewDidLoad() {
		super.viewDidLoad()
		//header
		sensor?.text = "Sensor: " + (selectedSensor?.Name)!
		//IP?.text = "IP: " + (selectedSensor?.IP)!

	}
	
	//MARK: - TableView Datasource Methods
	
	//MARK:- Table View Delegate Methods
	
	//MARK: - UI Buttons/Human Interaction.
	
	
	@IBAction func updateData(_ sender: Any) {
		temper.text = "\(arc4random_uniform(80))"
		humid.text = "\(arc4random_uniform(80))"
		lumino.text = "\(arc4random_uniform(80))"
	}
	
	

	@IBAction func ShowChart(_ sender: Any) {
	performSegue(withIdentifier: "goToChart", sender: self)
	}

	//MARK: - Helper functions
	private func updateInfoView() {
		sensor.text = selectedSensor?.Name
	}
	
	
}
