//
//  DataPageController.swift
//  HouseMonitor
//
//  Created by Xiaofei Guo on 4/29/18.
//  Copyright © 2018 Xiaofei Guo. All rights reserved.
//

import UIKit

class DataPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
//	var dataArray = [arc4random(80), arc4random(80), arc4random(80), arc4random(80), arc4random(80), arc4random(80)]
	var selectedSensor: Sensor?{
		didSet{
			//do things...
		}
	}
	lazy var orderedViewController: [UIViewController] = {
		return [self.newVC(viewController: "statistics"),
				self.newVC(viewController: "graphs")]
		
	}()
	
	var pageControl = UIPageControl()
	
	func configurePageControl(){
		pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 90, width: UIScreen.main.bounds.width, height: 50))
		pageControl.numberOfPages = orderedViewController.count
		pageControl.currentPage = 0
		pageControl.tintColor = UIColor.brown
		pageControl.pageIndicatorTintColor = UIColor.black
		pageControl.currentPageIndicatorTintColor = UIColor.brown
		self.view.addSubview(pageControl)
	}
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewController.index(of: viewController) else{
			return nil
		}
		let previousIndex = viewControllerIndex - 1
		guard  previousIndex >= 0 else {
			return nil
		}
		guard orderedViewController.count > previousIndex else{
			return nil
		}
		return orderedViewController[previousIndex]
	}
	
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewController.index(of: viewController) else{
			return nil
		}
		let nextIndex = viewControllerIndex + 1
		guard  orderedViewController.count != nextIndex else {
			return nil
		}
		guard orderedViewController.count > nextIndex else{
			return nil
		}
		return orderedViewController[nextIndex]
	}
	

    override func viewDidLoad() {
		super.viewDidLoad()
		self.dataSource = self
		if let firstViewController = orderedViewController.first{
			setViewControllers([firstViewController], direction: .reverse, animated: true, completion: nil)
			
		}
		self.delegate = self
		configurePageControl()

        // Do any additional setup after loading the view.
    }

	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		let pageContentViewControler = pageViewController.viewControllers![0]
		self.pageControl.currentPage = orderedViewController.index(of: pageContentViewControler)!
	}
	
	func newVC( viewController:String ) -> UIViewController{
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:viewController)
		
	}

}
