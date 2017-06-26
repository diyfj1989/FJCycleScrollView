//
//  FJTestTableViewCell.swift
//  swiftLunBoTest
//
//  Created by fengjie on 16/11/17.
//  Copyright © 2016年 hanzgrp. All rights reserved.
//

import UIKit
import SnapKit

class FJTestTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    fileprivate func setup() {
        
        contentView.backgroundColor = UIColor.lightGray
        contentView.addSubview(imageV)
        contentView.addSubview(titleLabel)
        //frame
//        imageV.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
//        titleLabel.frame = CGRect(x: 70, y: 25, width: 200, height: 20)
        
        //snapkit 框架
        contentView.snp.makeConstraints { (make) in
             make.edges.equalTo(UIEdgeInsetsMake(10, 10, 0, 10))
        }

        imageV.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(10)
            make.width.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(25)
            make.left.equalTo(imageV.snp.right).offset(10)
            make.height.equalTo(20)
        }
    }
    
    
    // MARK: - lazyload
    fileprivate var imageV: UIImageView = {
        let imagev = UIImageView()
        imagev.image = UIImage.init(named: "a1")
        return imagev
    }()
    
    fileprivate var titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 20)
        lab.textAlignment = .center
        lab.textColor = UIColor.blue
        lab.text = "这个demo啦啦啦啦啦"
        return lab
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
