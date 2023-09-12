//
//  UITableViewCell+App.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import Foundation
import UIKit

extension UITableViewCell {

    static var reuseIdentifier: String {
        String(describing: self)
    }
}
