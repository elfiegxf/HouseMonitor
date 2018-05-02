//
//  SecondPageViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 5/2/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit
import PNChart

class SecondPageViewController: UIViewController, PNChartDelegate, UIScrollViewDelegate {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let barChart = self.setBarChart()
		self.view.addSubview(barChart)
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
		label.center = CGPoint(x: 100, y: 120)
		label.textAlignment = .center
		label.text = "Temperature"
		label.textColor = UIColor.brown
		self.view.addSubview(label)
	}
	private func setBarChart() -> PNBarChart {
		let barChart = PNBarChart(frame: CGRect(x: 0, y: 135, width: 320, height: 200))
		barChart.backgroundColor = UIColor.clear
		barChart.animationType = .Waterfall
		barChart.labelMarginTop = 5.0
		barChart.xLabels = ["Sep 1", "Sep 2", "Sep 3", "Sep 4", "Sep 5", "Sep 6", "Sep 7"]
		barChart.yValues = [1, 23, 12, 18, 30, 12, 21]
		barChart.strokeChart()
		barChart.center = self.view.center
		return barChart
	}
}
