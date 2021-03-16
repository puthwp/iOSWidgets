//
//  AccountCardsView.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 22/2/2564 BE.
//

import Foundation
import UIKit
import SkeletonView

public protocol TTBAccountCardViewsProtocol: class {
    func createCardViews(_ controller: UIViewController?) -> [DisplayAccountItems]
    func cardDidSelected(_ vc: UIViewController,item: DisplayAccountItems, at index: Int)
    func controller() -> UIViewController
    func dismiss(_ controller: UIViewController?)
}

@IBDesignable
public class AccountCardsView: UIView {

    private enum Constants {
        static let titleFont = UIFont.h3WhiteLeft
        static let titleHeight: CGFloat = 23
        static let collectionHeight: CGFloat = 103
        static let pagingH: CGFloat = 8
        static let smallSpacing: CGFloat = 8
        static let normalSpacing: CGFloat = 16
        static let padding: CGFloat = 16
        static let cardSpacing: CGFloat = 12
        static let cardSize = CGSize(width: UIScreen.main.bounds.width - cardInset.left - cardInset.right, height: Constants.collectionHeight)
        static let cardInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        static let maximumPagingDot: Int = 6
    }
    
    private let scrollView = UIScrollView(frame: .zero)
    private let contenView = UIStackView(frame: .zero)
    private let titleLabel: UILabel = UILabel()
    private let paging: UIPageControl = UIPageControl()
    private let maxPagingNumber = 6
    private var allItems: [DisplayAccountItems]? {
        didSet {
            setupCardViews(allItems)
        }
    }
    
    public var currentIndex: Int {
        return Int(scrollView.contentOffset.y / scrollView.frame.width)
    }
    
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    @IBInspectable var titleColor: UIColor = .primaryHonestWhite {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    weak var datasource: TTBAccountCardViewsProtocol? {
        didSet {
            allItems = datasource?.createCardViews(nil)
            paging.numberOfPages = numberOfPagingDot
        }
    }
    
    private var numberOfPagingDot: Int {
        let dotsCount = allItems?.count ?? 0
        return dotsCount > Constants.maximumPagingDot ? Constants.maximumPagingDot : dotsCount
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func setupLayout() {
        self.clipsToBounds = true
        contenView.translatesAutoresizingMaskIntoConstraints = false
        contenView.axis = .horizontal
        contenView.distribution = .fill
        contenView.spacing = 0
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
        self.addSubview(paging)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        paging.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = Constants.titleFont
        titleLabel.textColor = titleColor
        titleLabel.text = title
        
        paging.numberOfPages = numberOfPagingDot
        paging.currentPageIndicatorTintColor = .primaryHonestWhite
        paging.pageIndicatorTintColor = .primaryTrustedNavy
        
        addViewContraints()
        reloadCards(nil)
    }
    
    public func reloadCards(_ onComplete: (()-> Void)?) {
        allItems = datasource?.createCardViews(nil)
        guard let items = allItems else {
            let view = AccountCardsViewItem()
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: Constants.cardSize.height),
                view.widthAnchor.constraint(equalToConstant: Constants.cardSize.width)
            ])
            view.accountIconImageView.showAnimatedSkeleton(usingColor: SkeletonAppearance.default.tintColor,
                                                           animation: nil,
                                                           transition: .crossDissolve(0.25))
            view.accountNameLabel.showAnimatedSkeleton(usingColor: SkeletonAppearance.default.tintColor,
                                                       animation: nil,
                                                       transition: .crossDissolve(0.25))
            view.accountNumberLabel.showAnimatedSkeleton(usingColor: SkeletonAppearance.default.tintColor,
                                                         animation: nil,
                                                         transition: .crossDissolve(0.25))
            view.amountLabel.showAnimatedSkeleton(usingColor: SkeletonAppearance.default.tintColor,
                                                  animation: nil,
                                                  transition: .crossDissolve(0.25))
            contenView.addArrangedSubview(view)
            return
        }
        paging.numberOfPages = numberOfPagingDot
        contenView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        items.forEach {
            let view = AccountCardsViewItem($0)
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: Constants.cardSize.height),
                view.widthAnchor.constraint(equalToConstant: Constants.cardSize.width)
            ])
            contenView.addArrangedSubview(view)
        }
        onComplete?()
    }
    
    public func scrollToItem(index: Int, animate: Bool) {
        let offsetY = index * Int(scrollView.bounds.width)
        scrollView.contentOffset = CGPoint(x: offsetY, y: 0)
    }
    
    private func addViewContraints() {
        let views = [
            "title": titleLabel,
            "collection": scrollView,
            "paging": paging
        ]
        let metrics = [
            "padding": Constants.padding,
            "titleH": Constants.titleHeight,
            "collectionH": Constants.collectionHeight,
            "pagingH" : Constants.pagingH,
            "normal": Constants.normalSpacing,
            "small": Constants.smallSpacing,
            "lPadding": Constants.cardInset.left,
            "rPadding": Constants.cardInset.right
        ]
        let allConstV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[title(titleH)]-small-[collection(103)]-normal-[paging(pagingH)]-0-|",
                                                       options: .directionLeftToRight,
                                                       metrics: metrics,
                                                       views: views)
        let collectionConstH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-lPadding-[collection]-rPadding-|",
                                                              options: .directionLeftToRight,
                                                              metrics: metrics,
                                                              views: views)
        let titleConstH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[title]-padding-|",
                                                         options: .directionLeftToRight,
                                                         metrics: metrics,
                                                         views: views)
        let pagingContsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[paging]-|",
                                                          options: .alignAllCenterX,
                                                          metrics: metrics,
                                                          views: views)
        
        self.addConstraints([
            allConstV,
            titleConstH,
            collectionConstH,
            pagingContsH
        ].flatMap { $0 })
    }
    
    private func setupCardViews(_ items: [DisplayAccountItems]?) {
        scrollView.addSubview(contenView)
        NSLayoutConstraint.activate([
            contenView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contenView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contenView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contenView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0)
        ])
    }
}


extension AccountCardsView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        paging.currentPage = index % Constants.maximumPagingDot
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        guard let item = allItems?[index] else {
            return
        }
        
        datasource?.cardDidSelected((self.datasource?.controller())!, item: item, at: index)
    }
}
