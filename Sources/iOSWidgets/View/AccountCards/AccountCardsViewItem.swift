//
//  AccountCardsViewItem.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 23/2/2564 BE.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

public class AccountCardsViewItem: UIView, LoadableNib {
    
    private enum Design {
        
        static let cornerRadius: CGFloat = 16
        
        enum Name {
            static let font = UIFont.h3NavyRight
            static let color = UIColor.primaryTrustedNavy
        }
        
        enum Account {
            static let font = UIFont.subtitleGreyLeft
            static let color = UIColor.helpingTextDefault
        }
        
        enum Amount {
            static let font = UIFont.h2NavyLeft
            static let color = UIColor.primaryTrustedNavy
        }
    }
    
    @IBOutlet weak var accountIconImageView: UIImageView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var wrapper: UIStackView!
    @IBOutlet weak var containerView: UIView!
    
    
    var item: CardDisplayItems?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loadView(bundle: .module))
        initSubView(container: containerView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(loadView(bundle: .module))
        initSubView(container: containerView)
        setupLayout()
    }
    
    init(_ item: CardDisplayItems) {
        super.init(frame: .zero)
        self.addSubview(loadView(bundle: .module))
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 6)
        ])
        setItem(item)
        setupLayout()
    }
    
    func setupLayout() {
        self.backgroundColor = .clear
        self.containerView.clipsToBounds = true
        self.containerView.backgroundColor = .primaryHonestWhite
        self.containerView.layer.cornerRadius = Design.cornerRadius
        
        accountIconImageView.layer.cornerRadius = accountIconImageView.frame.width / 2
        accountNameLabel.font = Design.Name.font
        accountNameLabel.textColor = Design.Name.color
        accountNumberLabel.font = Design.Account.font
        accountNumberLabel.textColor = Design.Account.color
        amountLabel.font = Design.Amount.font
        amountLabel.textColor = Design.Amount.color
        
        accountNameLabel.isSkeletonable = true
        accountNumberLabel.isSkeletonable = true
        amountLabel.isSkeletonable = true
        accountIconImageView.isSkeletonable = true
        self.showAnimatedSkeleton()
    }
    
    func setItem(_ item: CardDisplayItems?) {
        guard let item = item else {
            return
        }
        accountIconImageView.sd_setImage(with: item.accountIconURL, completed: nil)
        accountNameLabel.text = item.accountName
        accountNumberLabel.text = item.accountNumber
        amountLabel.text = item.displayAmount
    }
    
}

public protocol CardDisplayItems {
    var accountIconURL: URL? { get set }
    var accountName: String? { get set }
    var accountNumber: String? { get set }
    var displayAmount: String? { get set }
}
