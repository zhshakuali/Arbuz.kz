//
//  BasketViewController.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 16.05.2024.
//

import UIKit
import SwiftUI

class BasketViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    lazy var emptyView: UIHostingController = {
        let controller = UIHostingController(rootView: EmptyBasketView())
        return controller
    }()
    lazy var collectionView = CollectionView()
    var dataSource: UICollectionViewDiffableDataSource<Section, ProductModel>?
    var items: [ProductModel] = [.mockProduct1, .mockProduct2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        configureDataSource()
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.rootVC = self
        collectionView.register(
            HostingCollectionViewCell.self,
            forCellWithReuseIdentifier: "Cell"
        )
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HostingCollectionViewCell else { return UICollectionViewCell() }
            
            cell.embed(
                in: self,
                withContent: self.items[indexPath.row],
                onClose: { id in
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        self.removeProduct(for: id)
                    }
                },
                onFavorite: { id in
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        
                    }
                },
                onTap: {
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        self.showProductDetailView(self.items[indexPath.row])
                    }
                }
            )
            
            return cell
        }
        
        applySnapshot()
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
        addEmptyViewIfNeeded()
    }
    
    private func removeProduct(for id: Int) {
        items.removeAll(where: { $0.id == id })
        addEmptyViewIfNeeded()
        applySnapshot()
    }
    
    private func changeIsFavoriteState(for id: Int) {
        // Add to/Remove from favorites
    }
    
    private func addEmptyViewIfNeeded() {
        if items.isEmpty {
            addChild(emptyView)
            emptyView.view.frame = view.bounds
            view.addSubview(emptyView.view)
            emptyView.didMove(toParent: self)
        } else {
            emptyView.willMove(toParent: nil)
            emptyView.view.removeFromSuperview()
            emptyView.removeFromParent()
        }
    }
    
    private func showProductDetailView(_ product: ProductModel) {
        let vc = UIHostingController(
            rootView: ProductDetailView(
                product: product,
                onClose: {
                    self.presentedViewController?.dismiss(animated: true)
                }
            )
        )
        
        present(vc, animated: true)
    }
}

class CollectionView: UICollectionView {
    
    weak var rootVC: UIViewController!
    private let columnCount: Int = 1
    
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        setCollectionViewLayout(UICollectionViewCompositionalLayout(sectionProvider: layout), animated: false)
    }
    
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return .gridSection(columnCount: columnCount)
    }
}

extension NSCollectionLayoutSection {
    
    static func gridSection(columnCount: Int, showBadgeViews: Bool = false) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [])
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

extension UIView {
    
    func edgesToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.topAnchor),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor)
        ])
    }
}
