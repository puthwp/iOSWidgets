//
//  LoadableNib.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 23/2/2564 BE.
//

import Foundation
import UIKit

public protocol LoadableNib: UIView {
}

extension LoadableNib {
    public func loadView(bundle: Bundle = .main) -> UIView {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    public func initSubView(container: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0)
        ])
    }
}
