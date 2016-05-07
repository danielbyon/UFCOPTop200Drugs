//
//  ViewController.swift
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

import UIKit

final class ViewController: UITableViewController {
    
    @IBOutlet var genericNameLabel: UILabel!
    @IBOutlet var brandNameLabel: UILabel!
    @IBOutlet var majorClassLabel: UILabel!
    @IBOutlet var subclassLabel: UILabel!
    @IBOutlet var subclass2Label: UILabel!
    
    private lazy var flashcardProvider: FlashcardProvider = {
        return FlashcardProvider()
    }()
    
    private var flashcardGenerator: FlashcardGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashcardGenerator = FlashcardGenerator(provider: flashcardProvider)
        flashcardGenerator.delegate = self
        tableView.tableFooterView = UIView()
        showNextCard(self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let controller = (segue.destinationViewController as? UINavigationController)?.topViewController as? SettingsViewController else { assertionFailure(); return }
        controller.allMajorClasses = flashcardGenerator.allMajorClasses
        controller.currentMajorClasses = flashcardGenerator.currentMajorClasses
    }
    
    @IBAction func settingsDone(segue: UIStoryboardSegue) {
        guard let controller = segue.sourceViewController as? SettingsViewController else { assertionFailure(); return }
        flashcardGenerator.currentMajorClasses = controller.currentMajorClasses
        resetFlashcards(self)
    }
    
    @IBAction func showNextCard(sender: AnyObject) {
        let flashcard = flashcardGenerator.nextFlashcard()
        genericNameLabel.text = flashcard.genericName
        brandNameLabel.text = flashcard.brandName
        majorClassLabel.text = flashcard.majorClass
        subclassLabel.text = flashcard.subclass
        subclass2Label.text = flashcard.subclass2
    }

    @IBAction func resetFlashcards(sender: AnyObject) {
        let currentMajorClasses = flashcardGenerator.currentMajorClasses
        flashcardGenerator = FlashcardGenerator(provider: flashcardProvider)
        flashcardGenerator.delegate = self
        flashcardGenerator.currentMajorClasses = currentMajorClasses
        showNextCard(self)
    }
    
}

// MARK: - FlashcardGeneratorDelegate
extension ViewController: FlashcardGeneratorDelegate {
    
    func flashcardGeneratorDidLoopAllFlashcards(flashcardGenerator: FlashcardGenerator) {
        let alert = UIAlertController(title: nil, message: "All flashcards have been shown for the selected major classes, starting over.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
