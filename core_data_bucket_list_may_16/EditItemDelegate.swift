//
//  EditItemDelegate.swift
//  core_data_bucket_list_may_16
//
//  Created by Andy Feng on 5/16/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import Foundation

protocol EditItemDelegate: class {
    func doneEditing(editedItem: String)
}
