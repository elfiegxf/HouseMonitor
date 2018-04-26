//
//  BorderRouter.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/26/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import Foundation
class BorderRouter: Codable{
	private var Name : String = ""
	private var IP : String
	
	init(Name:String , IP:String) {
		self.Name = Name
		self.IP = IP
	}
	
	init(IP:String) {
		self.Name = "default"
		self.IP = IP
	}
	func setName(Name: String?){
		if Name == nil {
			self.Name = "default"
		}else{
		self.Name = Name!
		}
	}
	func getName() -> String {
		return self.Name
	}
	
	func setIP(IP: String?){
		if IP == nil {
			print("must be IPv6 address")
		}else{
			self.IP = IP!
		}
	}
	func getIP() -> String {
		return self.IP
	}
	
}
