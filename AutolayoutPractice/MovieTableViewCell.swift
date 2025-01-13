//
//  MovieTableViewCell.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/13/25.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    
    let numberLabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.backgroundColor = .white
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "movie name"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "yyyy-MM-dd"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [numberLabel, titleLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }
          setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .clear
    }
    
    func setupLayout() {
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(22)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(numberLabel.snp.trailing).offset(16)
            make.height.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configureData(_ data: Movie) {
        numberLabel.text = "\(data.number)"
        titleLabel.text = data.title
        dateLabel.text = data.date
    }
    
}
