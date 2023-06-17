//
//  MainViewController.swift
//  FirstAssignment
//
//  Created by Tsimafei Zykau on 17.06.23.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - UI Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var barButtonItem: UIBarButtonItem = {
        let menu = UIMenu(title: "Sort options", children: [
            UIAction(title: SortingOptions.alphabetical.rawValue) { [weak self] _ in
                self?.viewModel.switchSortingOption(.alphabetical)
            },
            UIAction(title: SortingOptions.frequency.rawValue) { [weak self] _ in
                self?.viewModel.switchSortingOption(.frequency)
            },
            UIAction(title: SortingOptions.length.rawValue) { [weak self] _ in
                self?.viewModel.switchSortingOption(.length)
            }])
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), menu: menu)
        return barButtonItem
    }()
    
    // MARK: - Properties
    var viewModel: MainViewModel
    
    // MARK: - Initialization
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelSetup()
        layout()
    }
    
    // MARK: - Methods
    private func viewModelSetup() {
        viewModel.reloadMainData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func layout() {
        navigationItem.rightBarButtonItem = barButtonItem
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        var content = cell.defaultContentConfiguration()
        let word = viewModel.words[indexPath.row]
        content.text = word.text
        content.secondaryText = "Used \(word.numberOfOccurrences) number of times"
        cell.contentConfiguration = content
        return cell
    }
}

