//
//  Hard1ViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 12/31/24.
//

import UIKit

class Hard1ViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var giftButton: UIButton!
    @IBOutlet var gridButton: UIButton!
    @IBOutlet var settingButton: UIButton!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    
    @IBOutlet var bottomView: UIView!
    @IBOutlet var selfChatButton: UIButton!
    @IBOutlet var profileEditButton: UIButton!
    @IBOutlet var kakaostoryButton: UIButton!
    
    @IBOutlet var buttonLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view.backgroundColor = UIColor.temp
        
        backgroundImageView.image = UIImage(named: "kakao_background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.8
        /*
         safearea 를 넘어서 영역을 덮고 싶은데 검색해본 메서드로는 잘 동작하지 않았다. (self.edgesForExtendedLayout)
         오토레이웃에서 위아래에 0보다 작은 값을 주면 괜찮지 않을까 했는데 에러가 발생, 이렇게 하는 것도 아닌 것 같다.
         여러가지 실험(?)을 해보다가 결국 배경화면과 같은 색으로 뷰 자체를 칠해서 임시방편으로 삼았다. ㅠㅠ
        */
                
        setTopView()
        setProfileView()
        setBottomView()
    }

    func setTopView() {
        topView.backgroundColor = .clear
        
        exitButton.setTitle("", for: .normal)
        exitButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        exitButton.tintColor = .white
        
        giftButton.setTitle("", for: .normal)
        giftButton.setImage(UIImage(systemName: "gift.circle"), for: .normal)
        giftButton.contentMode = .scaleAspectFill
        giftButton.tintColor = .white

        gridButton.setTitle("", for: .normal)
        gridButton.setImage(UIImage(systemName: "circle.grid.3x3.circle"), for: .normal)
        gridButton.tintColor = .white
        
        settingButton.setTitle("", for: .normal)
        settingButton.setImage(UIImage(systemName: "gearshape.circle"), for: .normal)
        settingButton.tintColor = .white
    }
    
    func setProfileView() {
        profileImageView.image = UIImage(named: "profileImage")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = (profileImageView.frame.height/2)-15
        
        nicknameLabel.text = "아이유"
        nicknameLabel.textColor = .white
        nicknameLabel.textAlignment = .center
    }
    
    func setBottomView() {
        bottomView.backgroundColor = .clear
        bottomView.layer.borderColor = UIColor.lightGray.cgColor
        bottomView.layer.borderWidth = 1
        /*
         뷰 상단에만 선을 하나 그리고 싶었는데 검색해보니 상단만 선택해서 border 을 넣을 수 있는 방법은 따로 없는 것 같았다.
         대부분 별도 view 를 만들어서 그걸 직선으로 붙이는 형식으로 하는 것 같은데, 너무 번거로운 방법인 것 같았다.
         지금은 하단 뷰에만 설정하려고 하고 있기 때문에, 뷰상자를 조금 더 크게 만들어 상단 직선만 화면에 나타나도록 그려보았다.
         */
        
        selfChatButton.setImage(UIImage(systemName: "bubble.fill"), for: .normal)
        selfChatButton.setTitle("", for: .normal)
//        selfChatButton.setTitle("나와의 채팅", for: .normal)
        selfChatButton.tintColor = .white
//        selfChatButton.alignVertical()
        
        profileEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        profileEditButton.setTitle("", for: .normal)
//        profileEditButton.setTitle("프로필 편집", for: .normal)
        profileEditButton.tintColor = .white
//        profileEditButton.alignVertical()
        
        kakaostoryButton.setImage(UIImage(systemName: "quote.closing"), for: .normal)
        kakaostoryButton.setTitle("", for: .normal)
//        kakaostoryButton.setTitle("카카오스토리", for: .normal)
        kakaostoryButton.tintColor = .white
//        kakaostoryButton.alignVertical()

        let labelTitles: [String] = ["나와의 채팅", "프로필 편집", "카카오스토리"]
        for index in 0..<buttonLabels.count {
            let label = buttonLabels[index]
            label.text = labelTitles[index]
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        }

    }
    
}

// 버튼의 이미지와 텍스트를 상하로 배치해주는 익스텐션을 발견했는데 오래되어서  그런지 deprecated 된 메서드들 뿐이다.
// inset 을 통해서 각 사이즈에 맞게 배치를 해주는 것 같은데 왜인지 내 결과물에는 적용되지 않는다. 결국 별도 라벨을 다시 붙여서 해결했다.
//extension UIButton {
//    func alignVertical(spacing: CGFloat = 6.0) {
//        guard let imageSize = self.imageView?.image?.size,
//            let text = self.titleLabel?.text,
//            let font = self.titleLabel?.font
//            else { return }
//        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
//        let labelString = NSString(string: text)
//        let titleSize = labelString.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: font])
//        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
//        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
//        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
//    }
//}
