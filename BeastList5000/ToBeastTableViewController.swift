//
//  ToBeastTableViewController.swift
//  BeastList5000
//
//  Created by Kioja Kudumu on 11/18/17.
//  Copyright © 2017 Kioja Kudumu. All rights reserved.
//

import UIKit
import CoreData

class ToBeastTableViewController: UITableViewController, AddItemViewControllerDelegate, CancelButtonDelegate {
 
    
    
    var items = [ToBeast]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    
    func fetchAllItems() {
        items = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToBeast")
        do {
            let results = try managedObjectContext.fetch(request)
            let resultsObject = results as? [ToBeast]
            for item in resultsObject! {
                items.append(item)
            }
        } catch {
            print("\(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToBeastCell", for: indexPath) as! ToBeastCell
        cell.beastLabel.text = items[indexPath.row].beast
        cell.beastButton.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(items[indexPath.row])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                fetchAllItems()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addItemViewController = navigationController.topViewController as! AddItemViewController
            addItemViewController.delegate = self
            addItemViewController.cancelButtonDelegate = self
        } else {
            let navigationController = segue.destination as! UINavigationController
            let addItemViewController = navigationController.topViewController as! AddItemViewController
            addItemViewController.delegate = self
            addItemViewController.cancelButtonDelegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                addItemViewController.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    func addItemViewController(sender: AddItemViewController, didFinishAddingBeast item: String) {
        dismiss(animated: true, completion: nil)
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "ToBeast", into: managedObjectContext) as! ToBeast
        
        newItem.beast = item
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                fetchAllItems()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
        
    }
    
    func addItemViewController(sender: AddItemViewController, didFinishEditingBeast item: ToBeast) {
        dismiss(animated: true, completion: nil)
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                fetchAllItems()
                tableView.reloadData()
            } catch {
                print("\(error)")
            }
        }
    }
    
    func cancelButtonPressed(controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Beasted", into: managedObjectContext) as! Beasted
        
        newItem.beast = items[sender.tag].beast
        newItem.date = NSDate() as Date
        managedObjectContext.delete(items[sender.tag])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                fetchAllItems()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
