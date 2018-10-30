//
//  ProjectsPagerVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/22/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

class ProjectsPagerVC: UIPageViewController {

    var presenter: ProjectPagerPresenter!
    var programId: Int!
    
    var pages: [ProjectPageVC] = []
    var pageControl = UIPageControl()
    // to return object of ProjectsPagerVC
    static func buildVC() -> ProjectsPagerVC {
        return ProjectsPagerVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Injector.provideProjectPagerPresenter()
        presenter.setView(view: self)
        presenter.getProjects(programId: programId)
        
        self.dataSource = self
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.AppColors.yellow
        self.view.addSubviews([pageControl])
    }
    
}

extension ProjectsPagerVC : ProjectPageView {
    func getWeeksSuccess(weeks: [Week]) {
        
    }
    
    func getCurrentWeekStatusSuccess(currentWeekStatus: CurrentWeekStatus) {
        
    }
    
    func opetaionFailed(message: String) {
        self.view.makeToast(message)
    }
    
    func getProjectsSuccess(projects: [Project]) {
        for project in projects {
            let vc = ProjectPageVC()
            vc.projectId = project.id
            vc.project = project
            pages.append(vc)
        }
        
        setViewControllers([pages.first!], direction: .reverse, animated: true, completion: nil)
        
        configurePageControl()
    }
}

extension ProjectsPagerVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! ProjectPageVC) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! ProjectPageVC) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let pagesCount = pages.count
        
        guard pagesCount != nextIndex else {
            return nil
        }
        
        guard pagesCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController as! ProjectPageVC)!
    }
}
