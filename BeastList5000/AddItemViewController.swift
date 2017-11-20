//
//  AddItemViewController.swift
//  BeastList5000
//
//  Created by Kioja Kudumu on 11/18/17.
//  Copyright © 2017 Kioja Kudumu. All rights reserved.
//

import UIKit


class AddItemViewController: UIViewController {
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEdit: ToBeast?
    
    @IBOutlet weak var beastTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        //without this if statement, we crash.
        if itemToEdit != nil {
        beastTextField.text = itemToEdit?.beast
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if itemToEdit == nil {
            let beast = beastTextField.text
             delegate?.addItemViewController(sender: self, didFinishAddingBeast: beast!)
        } else {
            itemToEdit?.beast = beastTextField.text
            delegate?.addItemViewController(sender: self, didFinishEditingBeast: itemToEdit!)
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    cancelButtonDelegate?.cancelButtonPressed(controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
