//
//  FlashcardGenerator.swift
//  DrugFlashcards
//
//  Copyright (c) 2016 Daniel Byon
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

protocol FlashcardGeneratorDelegate: class {
    
    func flashcardGeneratorDidLoopAllFlashcards(flashcardGenerator: FlashcardGenerator)
    
}

class FlashcardGenerator {
    
    private(set) var allFlashcards: [Flashcard]
    let allMajorClasses: [String]
    weak var delegate: FlashcardGeneratorDelegate?
    
    private var currentFlashcards: [Flashcard]
    var currentMajorClasses: Set<String> {
        didSet {
            currentFlashcards = allFlashcards.filter { currentMajorClasses.contains($0.majorClass) }
            usedFlashcards = Set<Flashcard>()
        }
    }
    private var usedFlashcards: Set<Flashcard>
    
    init(provider: FlashcardProvider) {
        allFlashcards = provider.flashcards
        currentFlashcards = provider.flashcards
        allMajorClasses = provider.majorClasses
        currentMajorClasses = Set(provider.majorClasses)
        usedFlashcards = Set<Flashcard>()
    }
    
    func nextFlashcard() -> Flashcard {
        
        func generateRandomIndex() -> Int {
            let index = Int(arc4random_uniform(UInt32(currentFlashcards.count)))
            assert(index >= 0 && index < currentFlashcards.count)
            return index
        }
        
        if usedFlashcards.count == currentFlashcards.count {
            delegate?.flashcardGeneratorDidLoopAllFlashcards(self)
            usedFlashcards = Set<Flashcard>()
        }
        
        while true {
            let index = generateRandomIndex()
            let flashcard = currentFlashcards[index]
            if !usedFlashcards.contains(flashcard) {
                usedFlashcards.insert(flashcard)
                debugPrint(usedFlashcards.count)
                return flashcard
            }
        }
    }
    
}
