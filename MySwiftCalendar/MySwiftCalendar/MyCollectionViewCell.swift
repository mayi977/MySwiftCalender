//
//  MyCollectionViewCell.swift
//  MySwiftCalendar
//
//  Created by Zilu.Ma on 16/7/8.
//  Copyright © 2016年 Zilu.Ma. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    var bgImg:UIImageView!
    var titleLab:UILabel!
    var dotImg:UIImageView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        bgImg = UIImageView(frame:CGRectMake(0, 0, 40, 40))
        self.contentView.addSubview(bgImg)
        
        titleLab = UILabel(frame:CGRectMake(0, 0, 40, 40))
        titleLab.textAlignment = NSTextAlignment.Center
        titleLab.textColor = UIColor.blackColor()
        titleLab.font = UIFont.systemFontOfSize(20)
        self.contentView.addSubview(titleLab)
        
        dotImg = UIImageView(frame:CGRectMake(16, 32, 8, 8))
        self.contentView.addSubview(dotImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
