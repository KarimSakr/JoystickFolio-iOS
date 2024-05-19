//
//  TabBarViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    lazy var tabBarBackground: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        let radius = self.tabBar.bounds.width * 3
        let centerX = self.tabBar.bounds.midX
        let tabBarHeight = self.tabBar.frame.height
        
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: radius - (tabBarHeight - 30)),
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat.pi,
                                clockwise: false)
        
        layer.path = path.cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.3
        
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.tabBar.layer.insertSublayer(tabBarBackground, at: 0)
        self.tabBar.itemPositioning = .centered
    }
}

extension TabBarViewController {
    
    fileprivate
    func setupTabs() {
        let home = createNav(with: "Home", and: UIImage(systemName: "gamecontroller"), vc: HomeViewController())
        let explore = createNav(with: "Explore", and: UIImage(systemName: "magnifyingglass"), vc: ExploreViewController())
        let events = createNav(with: "Events", and: UIImage(systemName: "calendar"), vc: EventsViewController())
        let threads = createNav(with: "Threads", and: UIImage(systemName: "network"), vc: ThreadsViewController())
        let profile = createNav(with: "Profile", and: UIImage(systemName: "person.circle"), vc: ProfileViewController())
        
        self.setViewControllers([home, explore, events, threads, profile], animated: true)
    }
    
    fileprivate
    func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        
        return nav
    }
}
