//
//  HamburgerMenuViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

protocol HamburgerMenuViewControllerOutput {
    
}

class HamburgerMenuViewController: BaseViewController {
    
    var interactor: HamburgerMenuViewControllerOutput?
    var router: HamburgerMenuRouter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var tableData = [[HamburgerMenuModels.ViewModels.CellModel]]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        HamburgerMenuConfigurator.shared.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- View Lifecycle
extension HamburgerMenuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModel()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            
            // Table constraints
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
}

// MARK: - Functions -
extension HamburgerMenuViewController {
    func resetTabBarAndNavigationController() {
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            AppSnackBar.make(in: self.view, message: error.localizedDescription, duration: .lengthShort)
                .show()
        }
    }
}

//MARK: - setup Table -
extension HamburgerMenuViewController {
    
    fileprivate
    func configureModel() {
        tableData.append([
            HamburgerMenuModels.ViewModels.CellModel(title: "Edit Profile") { [weak self] in
                guard let self = self else { return }
                tappedEditProfile()
            },
            
            HamburgerMenuModels.ViewModels.CellModel(title: "Invite Friends") { [weak self] in
                self?.tappedInviteFriends()
            },
        ])
        
        tableData.append([
            HamburgerMenuModels.ViewModels.CellModel(title: "Terms of Service") { [weak self] in
                guard let self = self else { return }
                openUrl()
            },
            HamburgerMenuModels.ViewModels.CellModel(title: "Privacy Policy"){ [weak self] in
                guard let self = self else { return }
                openUrl()
            },
            HamburgerMenuModels.ViewModels.CellModel(title: "Help and Feedback") { [weak self] in
                guard let self = self else { return }
                openUrl()
            }])
        
        tableData.append([
            HamburgerMenuModels.ViewModels.CellModel(title: "Support the developer") {
                //                guard let self = self else { return }
                // do something
            }
        ])
        
        tableData.append([
            HamburgerMenuModels.ViewModels.CellModel(title: "Log Out") { [weak self] in
                guard let self = self else { return }
                tappedLogOut()
            }
        ])
        
    }
    
    fileprivate func tappedEditProfile() {
        //TODO: implement feature
    }
    
    fileprivate func tappedInviteFriends() {
        //TODO: implement feature
    }
    
    fileprivate func openUrl() {
        //TODO: implement feature
    }
    
    fileprivate func tappedLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive) { [weak self] _ in
            
            guard let self = self else { return }
            
            self.logout()
            self.resetTabBarAndNavigationController()
            
        })
        
        present(actionSheet, animated: true)
    }
}


extension HamburgerMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = tableData[indexPath.section][indexPath.row]
        model.handler()
    }
}
