//
//  FlashcardProvider.swift
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

struct FlashcardProvider {
    
    let flashcards: [Flashcard]
    let majorClasses: [String]
    
    init(filename: String = "Drugs", extension: String = "csv") {
        
        func sanitizedComponent(component: String) -> String {
            return component.componentsSeparatedByString("|").joinWithSeparator(", ")
        }
        
        guard let fileURL = NSBundle.mainBundle().URLForResource("Drugs", withExtension: "csv") else { fatalError() }
        let contents = try! NSString(contentsOfURL: fileURL, encoding: NSUTF8StringEncoding)
        let lines = contents.componentsSeparatedByCharactersInSet(.newlineCharacterSet())
        var flashcards: [Flashcard] = []
        var majorClassesSet: Set<String> = []
        for line in lines.dropFirst() {
            let components = line.componentsSeparatedByString(",")
            guard components.count == 5 else { continue }
            let flashcard = Flashcard(
                genericName: sanitizedComponent(components[0]),
                brandName: sanitizedComponent(components[1]),
                majorClass: components[2],
                subclass: components[3],
                subclass2: components[4].isEmpty ? " " : components[4])
            flashcards.append(flashcard)
            majorClassesSet.insert(flashcard.majorClass)
        }
        
        self.flashcards = flashcards
        self.majorClasses = Array(majorClassesSet)
    }
    
}
