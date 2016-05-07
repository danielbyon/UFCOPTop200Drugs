//
//  SettingsViewController.swift
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

class SettingsViewController: UITableViewController {
    
    var allMajorClasses: [String]!
    var currentMajorClasses: Set<String>!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(allMajorClasses != nil && currentMajorClasses != nil)
        allMajorClasses.sortInPlace()
    }
    
    @IBAction func selectAllMajorClasses(sender: AnyObject) {
        allMajorClasses.forEach { currentMajorClasses.insert($0) }
        doneButton.enabled = true
        tableView.reloadData()
    }
    
    @IBAction func selectNone(sender: AnyObject) {
        currentMajorClasses.removeAll()
        doneButton.enabled = false
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource
extension SettingsViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMajorClasses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let majorClass = allMajorClasses[indexPath.row]
        cell.textLabel?.text = majorClass
        cell.accessoryType = currentMajorClasses.contains(majorClass) ? .Checkmark : .None
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SettingsViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let majorClass = allMajorClasses[indexPath.row]
        if currentMajorClasses.contains(majorClass) {
            currentMajorClasses.remove(majorClass)
        } else {
            currentMajorClasses.insert(majorClass)
        }
        
        doneButton.enabled = currentMajorClasses.count > 0
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
    
}
