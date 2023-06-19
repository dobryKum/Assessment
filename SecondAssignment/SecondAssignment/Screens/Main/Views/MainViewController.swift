//
//  MainViewController.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 17.06.23.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - UI Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Artist name (e.g. The Beatles)"
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Properties
    private var viewModel: MainViewModel
    
    // MARK: - Initialization
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        layout()
        viewModel.getAlbums()
    }
    
    //MARK: - Methods
    private func setupViewModel() {
        viewModel.reloadMainData = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.errorReceived = { [unowned self] model in
            AlertManager.showAlert(with: model, from: self)
        }
    }
    
    private func layout() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource methods
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albumsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        var content = cell.defaultContentConfiguration()
        content.text = "\(viewModel.albumsViewModels[indexPath.row].artistName) - \(viewModel.albumsViewModels[indexPath.row].albumName)"
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UISearchBarDelegate methods
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ? viewModel.getAlbums() : viewModel.getAlbums(artistName: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
