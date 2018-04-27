//
//  BorderRouter.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/26/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import Foundation
import RealmSwift
class BorderRouter: Object{
	@objc dynamic var Name : String = ""
	@objc dynamic var IP : String = ""
	var sensors = List<Sensor>()
}
