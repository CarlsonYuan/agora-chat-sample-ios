//
//  GroupListViewController.swift
//  PushNotifications
//
//  Created by Carlson Yuan on 2023/8/7.
//  Copyright © 2023 carlson. All rights reserved.
//
import UIKit
import CommonModule
import AgoraChat

final class GroupListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupListCell.self)
        return tableView
    }()
    
    
    private lazy var useCase: GroupListUseCase = {
        let useCase = GroupListUseCase()
        useCase.delegate = self
        return useCase
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "GroupList"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
                
        useCase.reloadGroups()
                
    }
}

// MARK: - UITableViewDataSource

extension GroupListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        useCase.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroupListCell = tableView.dequeueReusableCell(for: indexPath)
        let group = useCase.groups[indexPath.row]
        cell.configure(with: group)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension GroupListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let group = useCase.groups[indexPath.row]
        let groupViewController = GroupViewController(group: group)
        groupViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(groupViewController, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            useCase.loadNextPage()
        }
    }

}

// MARK: - GroupChannelListUseCaseDelegate

extension GroupListViewController: GroupListUseCaseDelegate {
    
    func groupListUseCase(_ groupListUseCase: GroupListUseCase, didReceiveError error: AgoraChatError) {
        DispatchQueue.main.async { [weak self] in
            self?.presentAlert(title: "error", message: error.description)
        }
    }
    func groupListUseCase(_ groupListUseCase: GroupListUseCase, didUpdateGroups groups: [AgoraChatGroup]) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}
