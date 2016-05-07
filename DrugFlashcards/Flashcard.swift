//
//  Flashcard.swift
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

struct Flashcard: Comparable, Equatable, Hashable {
    
    let genericName: String
    let brandName: String
    let majorClass: String
    let subclass: String
    let subclass2: String
    
    let hashValue: Int
    
    init(genericName: String, brandName: String, majorClass: String, subclass: String, subclass2: String) {
        self.genericName = genericName
        self.brandName = brandName
        self.majorClass = majorClass
        self.subclass = subclass
        self.subclass2 = subclass2
        self.hashValue = genericName.hashValue
    }
    
}

func <(lhs: Flashcard, rhs: Flashcard) -> Bool {
    return lhs.genericName.caseInsensitiveCompare(rhs.genericName) == .OrderedAscending
}

func ==(lhs: Flashcard, rhs: Flashcard) -> Bool {
    return lhs.genericName == rhs.genericName
}
