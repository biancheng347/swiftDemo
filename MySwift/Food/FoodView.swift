
import UIKit

class FoodView: UIView {
    fileprivate lazy var listView = lazyListView()
    fileprivate lazy var foodVM = FoodVM()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FoodView {
    var vm: FoodVM {
        foodVM
    }
}

fileprivate extension FoodView {
    func setUpView() {
        weakView(register: self)
        bind()
        
        foodVM.headerAction()
    }
    
    func bind() {
        [foodVM.error, foodVM.loading].bindToView(self)
        
        foodVM.modelsPublisher
            .asObservable()
            .bind(dispose: disposeBag, result: weakHandle { $0?.listView.proxyItemsReload(models: $1) })
    }
}

fileprivate extension FoodView {
    func lazyListView() -> ItemListView<ItemProxy> {
        return ItemListView().then {
            $0.cells = [FoodCell.self]
            $0.headerHandle = weakHandle { $0?.foodVM.headerAction() }
            $0.footerHandle = weakHandle { $0?.foodVM.footerAction() }
            $0.isFooterHandle = weakHandle { $0?.foodVM.isFooterAction() }
        }.make(self) {
            $0.edges.equalTo(self)
        }
    }
}

