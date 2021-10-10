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
    
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<Section, Content>) {
        dataSource.apply(snapshot)
    }
}

extension HomeView {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = Section.allCases[sectionIndex]
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
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Content> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Content>(
            collectionView: collectionView) { view, indexPath, item in
            // closure 로 함수를 정의해줬기 때문에, 그 함수가 여기서 계속 실행이 된다는 건가?
            let section = Section.allCases[indexPath.section]
            switch section {
            case .nearby:
                let registration = SmallSquareCell.registration()
                return view.dequeueConfiguredReusableCell(using: registration,
                                                          for: indexPath,
                                                          item: item)
            case .experiences:
                let registration = InvertedLargeSuqareCell.registration()
                return view.dequeueConfiguredReusableCell(using: registration,
                                                          for: indexPath,
                                                          item: item)
            case .info:
                let registration = FooterCell.registration() { indexPath in
                    indexPath.item % 4 != 3
                }
                return view.dequeueConfiguredReusableCell(using: registration,
                                                          for: indexPath,
                                                          item: item)
            default:
                let registration = LargeSquareCell.registration()
                return view.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
            }
        }
        
        let headers = Section.allCases.map(\.headerContent)
        let headerRegistration = SectionHeader.registration(headers: headers)
        let invertedRegistration = InvertedHeader.registration(headers: headers)
        dataSource.supplementaryViewProvider = { collectionView, string, indexPath in
            let section = Section.allCases[indexPath.section]
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
