//
//  CustomTableViewCell.swift
//  InnoTechExam
//
//  Created by edisonlin on 2020/8/7.
//  Copyright © 2020 edison. All rights reserved.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupThumbnailImageView()
        setupContentLabel()
    }
    
    private func setupThumbnailImageView() {
        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(150)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupContentLabel() {
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
