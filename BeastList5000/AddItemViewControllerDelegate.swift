//
//  AddItemViewControllerDelegate.swift
//  BeastList5000
//
//  Created by Kioja Kudumu on 11/18/17.
//  Copyright © 2017 Kioja Kudumu. All rights reserved.
//

import Foundation
import CoreData

protocol AddItemViewControllerDelegate: class {
    func addItemViewController(sender: AddItemViewController, didFinishAddingBeast item: String)
    func addItemViewController(sender: AddItemViewController, didFinishEditingBeast item: ToBeast)
}
