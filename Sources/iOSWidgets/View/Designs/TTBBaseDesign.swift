//
//  TTBBaseDesign.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 22/2/2564 BE.
//

import Foundation
import UIKit

private enum Design {
    static let halfScreenHeaderBackground = UIImage(named: "heading_background", in: .module, compatibleWith: .none) ?? UIImage()
    static let halfScreenContentRadius: CGFloat = 24
    static let halfScreenContentFrame = CGRect(x: 0, y: 280, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 280)
}

public protocol TTBBaseDesign: UIViewController {
    func setNavigationDesign()
}

public extension TTBBaseDesign {
    func setNavigationDesign() {
        if #available(iOS 14.0, *) {
            self.navigationItem.backButtonDisplayMode = .minimal
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.title = title
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

public protocol TTBBaseBlueDesign: TTBBaseDesign {
    func setTitleNavigation(title: String)
    func setupLayout()
}

public extension TTBBaseBlueDesign {
    
    func setTitleNavigation(title: String) {
        setNavigationDesign()
        self.navigationItem.title = title
        
        self.navigationController?.navigationBar.tintColor = .primaryHonestWhite
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.buttonBigWhiteLeft ?? UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.primaryHonestWhite
        ]
    }
    
    func setupLayout() {
        self.view.backgroundColor = UIColor(patternImage: Design.halfScreenHeaderBackground)
        let rect = CGRect(x: 0,
                          y: self.view.bounds.height / 2.0,
                          width: self.view.bounds.width,
                          height: self.view.bounds.height / 2.0)
        let path = UIBezierPath(rect: rect).cgPath
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.primaryHonestWhite.cgColor
        self.view.layer.insertSublayer(shape, at: 0)
    }
}

public protocol TTBBaseWhiteDesign: TTBBaseDesign {
    func setTitleNavigation(title: String)
    func setupLayout()
}

public extension TTBBaseWhiteDesign {
    
    func setTitleNavigation(title: String) {
        setNavigationDesign()
        self.navigationItem.title = title
        
        self.navigationController?.navigationBar.tintColor = .primaryTrustedNavy
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.h2NavyLeft ?? UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.primaryTrustedNavy
        ]
    }
    
    func setupLayout() {
        self.view.backgroundColor = .primaryHonestWhite
    }
}

