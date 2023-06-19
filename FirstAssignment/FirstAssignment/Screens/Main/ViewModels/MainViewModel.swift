//
//  MainViewModel.swift
//  FirstAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Properties
    var sortingOptions: [SortingOptions] = SortingOptions.allCases
    
    var words = [Word]() {
        didSet {
            reloadMainData?()
        }
    }
    
    var reloadMainData: (() -> Void)?
    
    private var textToWordsService: TextToWordsService
    
    private var selectedSortingOption: SortingOptions = .frequency {
        didSet {
            words.sort(by: selectedSortingOption.sortMethod)
        }
    }
    
    // MARK: - Initialization
    init(textToWordsService: TextToWordsService = TextToWordsService()) {
        self.textToWordsService = textToWordsService
        fillWords()
    }
    
    // MARK: - Methods
    func switchSortingOption(_ option: SortingOptions) {
        guard option != selectedSortingOption else { return }
        selectedSortingOption = option
    }
    
    private func fillWords() {
        switch textToWordsService.words() {
        case .success(let words):
            self.words = words.sorted(by: selectedSortingOption.sortMethod)
        case .failure(let error):
            // TODO: add normal error handling with showing alerts on main screen
            print(error.localizedDescription)
        }
    }
}
