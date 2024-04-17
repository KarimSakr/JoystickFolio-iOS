//
//  HamburgerMenuViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.

import UIKit

protocol HamburgerMenuDisplayLogic: AnyObject {
    
    var tableView: UITableView { get set }
    
    func resetTabBarAndNavigationController()
    
    func presentActionSheet(actionSheet: UIAlertController)
    
    func logout()
    
}

class HamburgerMenuViewController: UIViewController, HamburgerMenuDisplayLogic {
    
    var interactor: HamburgerMenuBusinessLogic?
    var router: HamburgerMenuRouter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
}

// MARK: View lifecycle
extension HamburgerMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
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
// MARK: - Functions
extension HamburgerMenuViewController {
    func resetTabBarAndNavigationController() {
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func presentActionSheet(actionSheet: UIAlertController) {
        present(actionSheet, animated: true)
    }
    
    func logout() {
        guard let interactor = interactor else { return }
        interactor.logout()
    }
}

// MARK: - Setup
extension HamburgerMenuViewController {
    private func setup() {
        let viewController = self
        let interactor = HamburgerMenuInteractor()
        let presenter = HamburgerMenuPresenter()
        let router = HamburgerMenuRouter()
        let repository = HamburgerMenuRepository()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.repository = repository
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}

extension HamburgerMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let interactor = interactor else { return 0 }
        return interactor.tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let interactor = interactor else { return 0 }
        return interactor.tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let interactor = interactor else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = interactor.tableData[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let interactor = interactor else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let model = interactor.tableData[indexPath.section][indexPath.row]
        model.handler()
    }
}
