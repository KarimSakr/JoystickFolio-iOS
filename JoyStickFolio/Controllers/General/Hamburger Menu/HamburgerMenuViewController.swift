//
//  HamburgerMenuViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 01/01/2024.
//

import UIKit

class HamburgerMenuViewController: UIViewController {
    
    //MARK: - View Models
    private let viewModel = HamburgerMenuViewModel()
    
    //MARK: - tableView
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var tableData = [[HamburgerMenuCell]]()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - configureModel
    private func configureModel() {
        tableData.append([
            HamburgerMenuCell(title: "Edit Profile") { [weak self] in
                self?.tappedEditProfile()
            },
            
            HamburgerMenuCell(title: "Invite Friends") { [weak self] in
                self?.tappedInviteFriends()
            },
        ])
        
        tableData.append([
            HamburgerMenuCell(title: "Terms of Service") { [weak self] in
                self?.openUrl()
            },
            HamburgerMenuCell(title: "Privacy Policy"){ [weak self] in
                self?.openUrl()
            },
            HamburgerMenuCell(title: "Help and Feedback") { [weak self] in
                self?.openUrl()
            }])
        
        tableData.append([
            HamburgerMenuCell(title: "Log Out") { [weak self] in
                self?.tappedLogOut()
            }
        ])
    }
    
    //MARK: - tappedEditProfile
    private func tappedEditProfile() {
        //TODO: implement feature
    }
    
    //MARK: - tappedInviteFriends
    private func tappedInviteFriends() {
        //TODO: implement feature
    }
    
    //MARK: - openUrl
    private func openUrl() {
        //TODO: implement feature
    }
    
    //MARK: - tappedLogOut
    private func tappedLogOut() {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive) { [weak self] _ in
            
            self?.tabBarController?.selectedIndex = 0
            self?.navigationController?.popToRootViewController(animated: false)
            
            self?.viewModel.logout()
        })
        
        present(actionSheet, animated: true)
    }
}

extension HamburgerMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableData.count
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
