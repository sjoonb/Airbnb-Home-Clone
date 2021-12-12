//
//  HomeView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import Anchorage
import UIKit

protocol HomeViewDelegate: AnyObject {
    func updateStatusBarStyle(to style: UIStatusBarStyle)
}

class HomeView: ProgrammaticView {
    
    weak var delegate: HomeViewDelegate?
    
    private let headerView = HeaderView()
    private lazy var collectionView = makeCollectionView()
    private lazy var dataSource = makeDataSource()
    private var oldYOffset: CGFloat = 0
    
    override func configure() {
        headerView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    override func constrain() {
        addSubviews(headerView, collectionView)

        // Anchorage package methods
        headerView.topAnchor == topAnchor
        headerView.horizontalAnchors == horizontalAnchors
        headerView.bottomAnchor == collectionView.topAnchor
        
        collectionView.horizontalAnchors == horizontalAnchors
        collectionView.bottomAnchor == bottomAnchor
    }
    
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<HomeSection, Content>) {
        dataSource.apply(snapshot)
    }
}

extension HomeView {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = HomeSection.allCases[sectionIndex]
            switch section {
            // 이후에 다른 layout 적용을 위해 switch 문을 사용하는듯.
            case .nearby:
                return .sideScrollingTwoItem()
            case .experiences:
                return .invertedSideScrollingOneItem()
            case .info:
                return .footer()
            default:
                return .sideScrollingOneItem()
            }
        }
        layout.registerBackgrounds()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    


    
    func makeDataSource() -> UICollectionViewDiffableDataSource<HomeSection, Content> {
        let smallSuqareCellRegistration = UICollectionView.CellRegistration<SmallSquareCell, Content> { cell, indexPath, content in
            cell.configure(with: content)
        }
        
        let invertedSuqareCellRegistration = UICollectionView.CellRegistration<InvertedLargeSuqareCell, Content> { cell, indexPath, content in
            cell.configure(with: content)
        }
        
        let footerSuqareCellRegistration = UICollectionView.CellRegistration<FooterCell, Content> { cell, indexPath, content in
            cell.configure(with: content)    
            let shouldShow = indexPath.item % 4 != 3
            cell.showSeparator(shouldShow)
        }
        
        let largeSuqareCellRegistration = UICollectionView.CellRegistration<LargeSquareCell, Content> { cell, indexPath, content in
            cell.configure(with: content)
        }
    
        let dataSource = UICollectionViewDiffableDataSource<HomeSection, Content>(
            collectionView: collectionView) { view, indexPath, item in
            let section = HomeSection.allCases[indexPath.section]
            switch section {
            case .nearby:
                let registration = smallSuqareCellRegistration
                return view.dequeueConfiguredReusableCell(using: registration,
                                                          for: indexPath,
                                                          item: item)
            case .experiences:
                let registration = invertedSuqareCellRegistration
                return view.dequeueConfiguredReusableCell(using: registration,
                                                          for: indexPath,
                                                          item: item)
            case .info:
                let registration = footerSuqareCellRegistration
                return view.dequeueConfiguredReusableCell(using: registration,
                                                          for: indexPath,
                                                          item: item)
            default:
                let registration = largeSuqareCellRegistration
                return view.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
            }
        }
        
        let headers = HomeSection.allCases.map(\.headerContent)
        let headerRegistration = SectionHeader.registration(headers: headers)
        let invertedRegistration = InvertedHeader.registration(headers: headers)
        dataSource.supplementaryViewProvider = { collectionView, string, indexPath in
            let section = HomeSection.allCases[indexPath.section]
            switch section {
            case .experiences:
                return collectionView.dequeueConfiguredReusableSupplementary(using: invertedRegistration, for: indexPath)
            default:
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            }
            
        }
        
        return dataSource
    }
}

extension HomeView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let updatedY = headerView.updateHeader(newY: yOffset, oldY: oldYOffset)
        scrollView.contentOffset.y = updatedY
        
        oldYOffset = scrollView.contentOffset.y
    }
}

extension HomeView: HeaderViewDelegate {
    
    func updateStatusBarStyle(to style: UIStatusBarStyle) {
        delegate?.updateStatusBarStyle(to: style)
    }
    
}
