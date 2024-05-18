//
//  MainScreen.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

class MainScreenViewController: UIViewController {
    
    lazy var mainScreen: UIHostingController = {
        let controller = UIHostingController(rootView: MainScreen { product in
            self.showProductDetailScreen(product)
        })
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMainScreen()
    }
    
    func addMainScreen() {
        addChild(mainScreen)
        mainScreen.view.frame = view.bounds
        view.addSubview(mainScreen.view)
        mainScreen.didMove(toParent: self)
    }
    
    func showProductDetailScreen(_ product: ProductModel) {
        let view = UIHostingController(
            rootView: ProductDetailView(
                product: product,
                onClose: {
                    self.presentedViewController?.dismiss(animated: true)
                }
            )
        )
        
        present(view, animated: true)
    }
}

struct MainScreen: View {
    
    let products: [ProductModel] = [
        .mockProduct1, 
        .mockProduct2,
        .mockProduct3,
        .mockProduct4
    ]
    
    let onTapProduct: (ProductModel) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), alignment: .top), GridItem(.flexible(), alignment: .top)], content: {
                ForEach(products) { product in
                    CellView(product: product)
                        .onTapGesture {
                            onTapProduct(product)
                        }
                }
            })
            .padding(.horizontal, 12)
        }
    }
}

#Preview {
    MainScreen { _ in
        
    }
}
