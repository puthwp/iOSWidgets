//
//  PrimaryRightIcon.swift
//  ComponentTest
//
//  Created by SIDDHANT-TCS on 16/2/2564 BE.
//

import UIKit

@IBDesignable
final class PrimaryRightIcon: UIButton {
    
    @IBInspectable var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
        }
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        self.clipsToBounds = true
        self.backgroundColor = .primaryRefreshingOrange
        self.layer.cornerRadius = 16
        //while setting title text you should only use setTitle:forControlState:. Do not use titleLabel to set any text for title directly.
        self.titleLabel?.font = UIFont(name: "Ekachon-Bold", size: 16)
        self.setTitleColor(.primaryHonestWhite, for: .normal)
        self.setImage(UIImage(named: "01Small16PxPlaceholder"), for: [])
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 16 )
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
       // self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        
    }
}
