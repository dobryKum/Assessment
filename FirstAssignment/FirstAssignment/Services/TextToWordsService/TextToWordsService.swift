//
//  TextParserService.swift
//  FirstAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

final class TextToWordsService {
    
    // MARK: - Properties
    private var fileName: String
    private var fileType: String
    private var fileEncoding: String.Encoding
    
    // MARK: - Initialization
    init(fileName: String = "Romeo-and-Juliet",
         fileType: String = "txt",
         fileEncoding: String.Encoding = .macOSRoman) {
        self.fileName = fileName
        self.fileType = fileType
        self.fileEncoding = fileEncoding
    }
    
    // MARK: - Methods
    func words() -> Result<[Word], TextToWordsServiceError> {
        guard let fileStringUrl = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            return .failure(.fileDoesNotExist)
        }
        do {
            let text = try String(contentsOfFile: fileStringUrl, encoding: fileEncoding)
            let separationCharacters = CharacterSet([".", "\r", " ", ",", "—"])
            let trimmingCharacters = CharacterSet(["!", "?", "(", ")", ";", ":"])
            
            // I used this logic to save words with '-' as one word (and also save broken encoding words).
            // The optimal way to handle this will be of course by iterating with enumerateSubstrings(Range, by: .wordsCount)
            let wordsArray = text
                .components(separatedBy: separationCharacters)
                .filter { !$0.isEmpty }
                .map { $0.lowercased().trimmingCharacters(in: trimmingCharacters) }
            
            var wordsDictionary = [String: Int]()
            wordsArray.forEach {
                wordsDictionary[$0] = (wordsDictionary[$0] ?? 0) + 1
            }
            
            return .success(wordsDictionary.map { Word(text: $0.key, numberOfOccurrences: $0.value) })
        } catch {
            print("Error: \(error.localizedDescription)")
            return .failure(.parseFailure)
        }
    }
    
    // if supporting other included files will be needed, here could be added new method for changing file name, type and encoding
}

enum TextToWordsServiceError: Error {
    case fileDoesNotExist
    case parseFailure
}
