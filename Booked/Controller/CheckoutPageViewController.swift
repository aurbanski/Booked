//
//  CheckoutPageViewController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/12/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit

class CheckoutPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    lazy var pageViewControllers: [UIViewController] = [self.getVC(viewController: "cartView"), self.getVC(viewController: "billingInfo"), self.getVC(viewController: "shippingInfo"), self.getVC(viewController: "cardInfo")]
    
    var pageControl = UIPageControl()
    var currentPage = 0
    var address: Address?
    var totalCost: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        if let firstViewController = pageViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.delegate = self
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 200, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = pageViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor(red: 143.0, green: 213.0, blue: 166.0, alpha: 1.0)
        self.view.addSubview(pageControl)
    }
    
    func nextPage() {
        print("Here1")
        if currentPage < pageViewControllers.count {
            print("Here2")
            setViewControllers([pageViewControllers[currentPage + 1]], direction: .forward, animated: true, completion: nil)
            currentPage += 1
        }
    }
    
    func goToFirstPage() {
        let cartViewController = pageViewControllers[0] as! CartViewController
        cartViewController.deleteAllPostings()
        cartViewController.purchaseToast()
        
        setViewControllers([pageViewControllers[0]], direction: .forward, animated: true, completion: nil)
        currentPage = 0
    }
    
    func getVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else {
            return nil
//            return pageViewControllers.last
        }
        
        guard pageViewControllers.count > previousIndex else {
            return nil
        }
        
        return pageViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        
        guard pageViewControllers.count != nextIndex else {
            return nil
//            return pageViewControllers.first
        }
        
        guard pageViewControllers.count > nextIndex else {
            return nil
        }
        
        return pageViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pageViewControllers.index(of: pageContentViewController)!
        currentPage = pageViewControllers.index(of: pageContentViewController)!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
