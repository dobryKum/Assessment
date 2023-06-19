//
//  MainViewModel.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Properties
    private var albums = [Album]() {
        didSet {
            albumsViewModels = albums.map { AlbumCellViewModel(albumName: $0.albumName, artistName: $0.artistName) }
        }
    }
    
    private var albumsService: AlbumsService
    
    var reloadMainData: (() -> Void)?
    
    var errorReceived: ((AlertManager.ConfigurationModel) -> Void)?
    
    var albumsViewModels = [AlbumCellViewModel]() {
        didSet {
            reloadMainData?()
        }
    }
    
    // MARK: - Initialization
    init(albumsService: AlbumsService = AlbumsService()) {
        self.albumsService = albumsService
    }
    
    // MARK: - Methods
    func getAlbums(artistName: String = "The Beatles") {
        albumsService.getAlbums(with: artistName) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let albums):
                self.albums = albums
            case .failure(let error):
                let model = AlertManager.ConfigurationModel(title: "Something went wrong. Please try again later",
                                                            subtitle: error.localizedDescription)
                self.errorReceived?(model)
            }
        }
    }
}
