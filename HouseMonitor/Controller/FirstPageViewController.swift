//
//  FirstPageViewController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 5/2/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit
import PNChart

class FirstPageViewController: UIViewController, PNChartDelegate, UIScrollViewDelegate {

	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let tempChart = self.setLineChart()
		self.view.addSubview(tempChart)
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
		label.center = CGPoint(x: 100, y: 120)
		label.textAlignment = .center
		label.text = "Temperature"
		label.textColor = UIColor.brown
		self.view.addSubview(label)
	}
	private func setLineChart() -> PNLineChart {
		let lineChart = PNLineChart(frame: CGRect(x: 0, y: 135, width: 320, height: 250))
		lineChart.yLabelFormat = "%1.1f"
		lineChart.showLabel = true
		lineChart.backgroundColor = UIColor.clear
		lineChart.xLabels = ["Sep 1", "Sep 2", "Sep 3", "Sep 4", "Sep 5", "Sep 6", "Sep 7"]
		lineChart.showCoordinateAxis = true
		lineChart.center = self.view.center
		
		let dataArr = [60.1, 160.1, 126.4, 232.2, 186.2, 127.2, 176.2]
		let data = PNLineChartData()
		data.color = PNGreen
		data.itemCount = dataArr.count
		data.inflexPointStyle = .None
		data.getData = ({
			(index: Int) -> PNLineChartDataItem in
			let yValue = CGFloat(dataArr[index])
			let item = PNLineChartDataItem(y: yValue)
			return item
		})
		
		lineChart.chartData = [data]
		lineChart.strokeChart()
		return lineChart
	}
}
