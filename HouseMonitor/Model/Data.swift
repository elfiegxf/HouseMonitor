
//
//  Data.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/27/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
	@objc dynamic var DataType : String = ""
	@objc dynamic var Value : Float = 0.0
	var parentSensor = LinkingObjects(fromType: Sensor.self, property: "sensorData")
}
