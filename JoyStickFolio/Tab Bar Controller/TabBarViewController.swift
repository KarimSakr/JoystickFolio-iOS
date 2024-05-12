//
//  TabBarViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
}

extension TabBarViewController {
    
    fileprivate
    func setupTabs() {
        let home = createNav(with: "Home", and: UIImage(systemName: "gamecontroller"), vc: HomeViewController())
        let explore = createNav(with: "Explore", and: UIImage(systemName: "magnifyingglass"), vc: ExploreViewController())
        let events = createNav(with: "Events", and: UIImage(systemName: "calendar"), vc: EventsViewController())
        let threads = createNav(with: "Threads", and: UIImage(systemName: "network"), vc: ThreadsViewController())
        let profile = createNav(with: "Profile", and: UIImage(systemName: "person.circle"), vc: ThreadsViewController())
        
        self.setViewControllers([home, explore, events, threads, profile], animated: true)
    }
    
    fileprivate
    func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        
        return nav
    }
}
