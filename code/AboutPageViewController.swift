//
//  AboutPageViewController.swift
//  Discuss Action
//
//  Copyright © 2017 Brandon Siebert. All rights reserved.
//

import Foundation
import UIKit

// MARK: Base Page View Controller (WRITTEN BY BRANDON SIEBERT)

class AboutPageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutPage1"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutPage2"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutPage3")]
    }()
    
    private var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Confirm from console that the application has successfully loaded
        print("[DA-LOG] Application Has Loaded")
        
        // Set in user defaults that the about screen has been shown already on startup
        UserDefaults.standard.set(true, forKey: "shown_startup_about")
        
        // Set self as
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        // Create the page tracker (dots at the bottom)
        pageControl = UIPageControl(frame: CGRect(x: 0,
                                                  y: UIScreen.main.bounds.maxY - 70,
                                                  width: UIScreen.main.bounds.width,
                                                  height: 50))
        
        self.pageControl.numberOfPages = 3//orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.view.addSubview(pageControl)
        
    }
    
    @IBAction func event_list(_ sender: Any) {
    }
    
}

// MARK: Page View Data Source - How Pages Navigate (FRAMEWORK)

extension AboutPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // Navigate left in the page view
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewControllerBefore) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    // Navigate right in the page view
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewControllerAfter) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    // Return the number of view controllers contained in our page view
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    // Return index for the first view controller in our page view
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    // Update the navigation dot to display the current page
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
}
