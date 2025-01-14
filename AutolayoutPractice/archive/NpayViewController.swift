//
//  NpayViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/13/25.
//

import UIKit
import SnapKit

class NpayViewController: UIViewController {
    
    let segmentedControl = {
        let items: [String] = ["멤버십", "현장결제", "쿠폰"]
        let control = UISegmentedControl(items: items)
        let normalTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        let selectedTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        control.selectedSegmentTintColor = .darkGray
        control.setTitleTextAttributes(normalTitleAttributes, for: .normal)
        control.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
        control.selectedSegmentIndex = 1
        return control
    }()
    
    let popupView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    
    let logoImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "npay_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let pullDownButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 7, weight: .regular, scale: .default)
        let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: config)
        let button = UIButton()
        button.setTitle("국내", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.tintColor = .lightGray
        return button
    }()
    
    let exitButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let lockImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "npay_lock")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainGuideLabel = {
        let label = UILabel()
        label.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let checkButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 13
        button.backgroundColor = .npayGreen
        return button
    }()
    
    let instancePayDescriptionLabel = {
        let label = UILabel()
        label.text = "바로결제 사용하기"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let confirmButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .npayGreen
        button.layer.cornerRadius = 22
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = false
        
        setSegmentedControlView()
        setPopupView()
    }
    
    func setSegmentedControlView() {
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    func setPopupView() {
        let topView = UIView()
        [logoImageView, pullDownButton, exitButton].forEach {
            topView.addSubview($0)
        }

        let instancePayView = UIView()
        [checkButton, instancePayDescriptionLabel].forEach {
            instancePayView.addSubview($0)
        }

        [topView, lockImageView, mainGuideLabel, instancePayView, confirmButton].forEach { popupView.addSubview($0) }

        view.addSubview(popupView)
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(-266)
            make.horizontalEdges.equalTo(view).inset(16)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
        }
                
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalTo(16)
            make.height.equalTo(24)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(60)
        }
        
        pullDownButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.leading.equalTo(logoImageView.snp.trailing).offset(4)
            make.height.equalTo(12)
        }
        
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.size.equalTo(30)
            make.centerY.equalTo(logoImageView.snp.centerY)
        }

        lockImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(50)
            make.size.equalTo(120)
        }
        
        mainGuideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lockImageView.snp.bottom).offset(12)
        }
        
        instancePayView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainGuideLabel.snp.bottom).offset(50)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(26)
        }
        
        instancePayDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(checkButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(instancePayView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(44)
        }
        
    }
}

#Preview {
    NpayViewController()
}
