//
//  HomeTableViewController.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/9/21.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tableViewHeader = UIView()
    var presenter: ViewPresenter?
    let sections = ["Pinned", "Top repositories", "Starred repositories"]
    
    var pinndedRepositories:[Node] = []
    var topRepositories:[Node] = []
    var starredRepositories:[Node] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
        presenter = ViewPresenter()
        presenter?.delegate = self
        presenter?.loadData()
    }
    
    func setupTableView() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        self.tableView.estimatedRowHeight = 150
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView.register(RepositoryCell.self, forCellReuseIdentifier: "repositoryCellIdentifier")
    }
    
    @objc func refresh(sender:AnyObject) {
        presenter?.loadData(reloadFromServer: true)
        self.refreshControl!.endRefreshing()
        self.tableView.contentOffset = CGPoint.zero
        
    }
}

// MARK: - Table view data source
extension HomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return pinndedRepositories.count
        } else if section == 1 {
            return topRepositories.count
        }
        return starredRepositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCellIdentifier", for: indexPath) as! RepositoryCell
        if indexPath.section == 0  {
            cell.setupCell(repository: pinndedRepositories[indexPath.row])
        } else if indexPath.section == 1  {
            cell.setupCell(repository: topRepositories[indexPath.row])
        } else if indexPath.section == 2  {
            cell.setupCell(repository: starredRepositories[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
}

// MARK: - Table view delegate
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension HomeTableViewController: ViewPresenterDelegate {
    func updateView(user: User) {
        let headerView = HeaderView()
        headerView.currentUser = user
        headerView.setup()
        tableViewHeader = headerView
        self.tableView.tableHeaderView = tableViewHeader
        
        if let pinnedItems = user.pinnedItems {
            if let nodes = pinnedItems.nodes {
                self.pinndedRepositories = nodes
            }
        }
        
        if let topRepositories = user.repositories {
            if let nodes = topRepositories.nodes {
                self.topRepositories = nodes
            }
        }
        
        if let starredRepositories = user.starredRepositories {
            if let nodes = starredRepositories.nodes {
                self.starredRepositories = nodes
            }
        }
        
        self.tableView.reloadData()
    }
    
    func responseFailed() {
        let alert = UIAlertController(title: "Alert", message: "Faild To load From server", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.refreshControl!.endRefreshing()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
