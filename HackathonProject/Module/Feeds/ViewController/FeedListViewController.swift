//
//  FeedListViewController.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

import UIKit

class FeedListViewController: UIViewController {
    
    var feedTableView: UITableView!
    var labelNoDataFound: UILabel!
    
    var viewModel = FeedListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpPage()
    }
    
    private func setUpUI() {
        labelNoDataFound = UILabel(frame: CGRect(x: 149, y: 437, width: 151, height: 21))
        setUpTableView()
        
        self.view.backgroundColor = .lightGray
        self.view.addSubview(feedTableView)
        self.view.addSubview(labelNoDataFound)
        
        setUpTableViewConstraints()
    }
    
    func setUpTableView() {
        feedTableView = UITableView()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.rowHeight = UITableView.automaticDimension
        
        feedTableView.tableFooterView = UIView()
        feedTableView.register(FeedListTableViewCell.self, forCellReuseIdentifier: AppConstants.feedListTableViewIdentifier)
    }
    
    func setUpTableViewConstraints() {
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        feedTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        feedTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setUpPage() {
        title = "Feed List"
        closureSetup()
        getFeedList()
    }
    
    private func getFeedList() {
        showSpinner(onView: self.view)
        viewModel.getFeedListData()
    }
    
    func tableViewReload() {
        removeSpinner()
        feedTableView.reloadData()
    }

    // Closure setup methods
    private func closureSetup() {
        // add error handling
        viewModel.onErrorHandling = { [weak self] error in
            DispatchQueue.main.async {
                self?.removeSpinner()
                
                switch error {
                case .custom(let message):
                    self?.displayAlert(message: message)
                    break
                default:
                    self?.displayAlert(message: error?.localizedDescription ?? "Error")
                    break
                }
            }
        }
        
        // refresh screen
        viewModel.onRefreshHandling = { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewReload()
            }
        }
    }
}

// MARK: - UITableView methods
extension FeedListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = viewModel.feedListArray.count
        labelNoDataFound.isHidden = ((rowCount == 0) ? false : true)
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.feedListTableViewIdentifier, for: indexPath) as? FeedListTableViewCell else {
            fatalError("Cell not exists")
        }

        if viewModel.feedListArray.count > 0 {
            let feed = viewModel.feedListArray[indexPath.row]
            cell.configure(data: feed)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rowCount = viewModel.feedListArray.count
        
        if (indexPath.row == (rowCount - 1)) {
            // load more data when reached last index
            getFeedList()
        }
    }
}
