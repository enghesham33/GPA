//
//  TutorialPagerVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit

public protocol TutorialPagerDelegate: class {
    func goToChooseAvatar()
}

class TutorialPagerVC: UIPageViewController, TutorialPagerDelegate {
    func goToChooseAvatar() {
        self.navigationController?.pushViewController(ChooseAvatarVC.buildVC(), animated: true)
    }
    

    var pageControl = UIPageControl()
    var page0 = TutorialPageVC()
    var page1 = TutorialPageVC()
    var page2 = TutorialPageVC()
    var page3 = TutorialPageVC()
    var page4 = TutorialPageVC()
    var page5 = TutorialPageVC()
    
    var pages: [TutorialPageVC]!
    
    // to return object of TutorialPagerVC
    static func buildVC() -> TutorialPagerVC {
        return TutorialPagerVC()
    }
    
    lazy var exitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "close")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (recognizer) in
//            popVC() go to program screen
        })
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        page0.index = 0
        page0.pageTitle = "page0Title".localized()
        page0.message = "page0Message".localized()
        page0.delegate = self
        
        page1.index = 1
        page1.pageTitle = "page1Title".localized()
        page1.message = "page1Message".localized()
        page1.delegate = self
        
        page2.index = 2
        page2.pageTitle = "page2Title".localized()
        page2.message = "page2Message".localized()
        page2.delegate = self
        
        page3.index = 3
        page3.pageTitle = "page3Title".localized()
        page3.message = "page3Message".localized()
        page3.delegate = self
        
        page4.index = 4
        page4.pageTitle = "page4Title".localized()
        page4.message = "page4Message".localized()
        page4.delegate = self
        
        page5.index = 5
        page5.pageTitle = "page5Title".localized()
        page5.message = "page5Message".localized()
        page5.delegate = self
        
        pages = [page0, page1, page2, page3, page4, page5]
        
        setViewControllers([pages.first!], direction: .reverse, animated: true, completion: nil)
        
        configurePageControlAndSetCloseIcon()
    }

    
    func configurePageControlAndSetCloseIcon() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.AppColors.yellow
        self.view.addSubviews([pageControl, exitImageView])
        
        self.exitImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(self.view.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.top.equalTo(self.view.snp.top).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension TutorialPagerVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! TutorialPageVC) else {
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
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! TutorialPageVC) else {
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
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController as! TutorialPageVC)!
    }
}
