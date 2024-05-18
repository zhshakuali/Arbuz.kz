//
//  HostingCollectionViewCell.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

final class HostingCollectionViewCell: UICollectionViewCell {
    
    private(set) var host: UIHostingController<CellView>?
    
    func embed(in parent: UIViewController, withContent content: ProductModel, onClose: @escaping (Int) -> Void, onFavorite: @escaping (Int) -> Void, onTap: @escaping () -> Void) {
        if let host = self.host {
            host.rootView = CellView(product: content, type: .cart)
            host.view.layoutIfNeeded()
        } else {
            let host = UIHostingController(
                rootView: CellView(product: content, type: .cart)
            )
            parent.addChild(host)
            host.didMove(toParent: parent)
            host.view.translatesAutoresizingMaskIntoConstraints = false
            
            contentView.addSubview(host.view)
            NSLayoutConstraint.activate([
                host.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                host.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                host.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                host.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                host.view.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                host.view.widthAnchor.constraint(equalToConstant: contentView.frame.width - 24)
            ])
            
            self.host = host
        }
    }
    
    deinit {
        host?.willMove(toParent: nil)
        host?.view.removeFromSuperview()
        host?.removeFromParent()
        host = nil
    }
}
