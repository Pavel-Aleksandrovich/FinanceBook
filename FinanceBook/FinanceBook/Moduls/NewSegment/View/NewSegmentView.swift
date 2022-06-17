//
//  NewSegmentView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol INewSegmentView: AnyObject {
    var saveButtonTappedHandler: (() -> ())? { get set }
}

final class NewSegmentView: UIView {
    
    var saveButtonTappedHandler: (() -> ())?
    private let saveButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.makeSaveButtonConstraints()
        self.configSaveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewSegmentView: INewSegmentView {}

private extension NewSegmentView {
    
    func configSaveButton() {
        self.saveButton.titleLabel?.text = "saveButton"
        self.saveButton.backgroundColor = .gray
        self.saveButton.addTarget(self,
                                  action: #selector(saveButtonTapped),
                                  for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        self.saveButtonTappedHandler?()
    }
    
    func makeSaveButtonConstraints() {
        self.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(60)
        }
    }
}
