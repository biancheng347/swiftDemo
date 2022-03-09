
import UIKit

class FoodCell: BaseCVCell {
    fileprivate lazy var titleLabel = lazyTitleLabel()
    fileprivate lazy var deleteButton = lazyDeleteButton()
    
    fileprivate weak var model: FoodModel?
    
    override func cell(model: ItemTypeProtocol) {
        (model as? ItemTypeModel<FoodModel>).map(\.data).map(myCell(model:))
    }
    
    override func cell(didSelect: IndexPath, model: ItemTypeProtocol) {
        (model as? ItemTypeModel<FoodModel>).map(\.data).map(myCell(didSelect:))
    }
}

fileprivate extension FoodCell {
    func myCell(model: FoodModel) {
        self.model = model
        titleLabel.text = model.data.title
    }
    
    func myCell(didSelect: FoodModel) {
        viewCacheVC?.navigationController?.pushViewController(FoodVC(), animated: true)
    }
}

fileprivate extension FoodCell {
    @objc func deleteAction() {
        guard let model = model else { return }
        weakView(fetch: FoodView.self)?.vm.delete(model: model)
    }
}

fileprivate extension FoodCell {
    func lazyTitleLabel() -> UILabel {
        return UILabel().then {
            $0.backgroundColor = .clear
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 14.rpx)
        }.make(self.contentView) {
            $0.edges.equalTo(self)
        }
    }
    
    func lazyDeleteButton() -> UIButton {
        return UIButton(type: .custom).then {
            $0.backgroundColor = .clear
            $0.setTitle("delete", for: .normal)
            $0.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        }.make(self.contentView) {
            $0.top.right.equalTo(self)
            $0.width.equalTo(50.rpx)
            $0.height.equalTo(30.rpx)
        }
    }
}
