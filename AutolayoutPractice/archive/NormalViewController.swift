//
//  NormalViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 12/31/24.
//

import UIKit

class NormalViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var pullDownButton: UIButton!
    
    @IBOutlet var exitButton: UIButton!
    
    @IBOutlet var lockImage: UIImageView!
    @IBOutlet var mainGuideLabel: UILabel!
    
    @IBOutlet var instancePayView: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var instancePayDescriptionLabel: UILabel!
    
    @IBOutlet var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        setSegmentedControlView()
        setPopupView()
    }
    
    func setSegmentedControlView() {
        let segmentTitle: [String] = ["멤버십", "현장결제", "쿠폰"]
        let normalTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        let selectedTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        for index in 0..<segmentedControl.numberOfSegments {
            segmentedControl.setTitle(segmentTitle[index], forSegmentAt: index)
            segmentedControl.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            segmentedControl.setTitleTextAttributes(selectedTitleAttributes, for: .normal)
            segmentedControl.selectedSegmentTintColor = .gray
            segmentedControl.backgroundColor = .black
        }
    }
    
    func setPopupView() {
        popupView.layer.cornerRadius = 16
        popupView.backgroundColor = .white
        
        logoImageView.image = UIImage(named: "npay_logo")
        logoImageView.contentMode = .scaleAspectFit
        
        let config = UIImage.SymbolConfiguration(pointSize: 7, weight: .regular, scale: .default)
        let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: config)
        pullDownButton.setTitle("국내", for: .normal)
        pullDownButton.setTitleColor(.lightGray, for: .normal)
        pullDownButton.setImage(image, for: .normal)
        pullDownButton.imageView?.contentMode = .scaleAspectFit
        pullDownButton.semanticContentAttribute = .forceRightToLeft
        pullDownButton.titleLabel?.adjustsFontSizeToFitWidth = true
        pullDownButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        pullDownButton.tintColor = .lightGray
        
        exitButton.setTitle("", for: .normal)
        exitButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        exitButton.tintColor = .black
        
        lockImage.image = UIImage(named: "npay_lock")
        lockImage.contentMode = .scaleAspectFit
        
        mainGuideLabel.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        mainGuideLabel.textColor = .black
        mainGuideLabel.textAlignment = .center
        mainGuideLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        mainGuideLabel.numberOfLines = 2
        
        instancePayView.backgroundColor = .clear
        
        checkButton.setTitle("", for: .normal)
        checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        checkButton.tintColor = .white
        checkButton.layer.cornerRadius = checkButton.frame.height/2
        checkButton.backgroundColor = .npayGreen
        
        instancePayDescriptionLabel.text = "바로결제 사용하기"
        instancePayDescriptionLabel.textColor = .black
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .npayGreen
        confirmButton.layer.cornerRadius = confirmButton.frame.height/2
    }
    
}
