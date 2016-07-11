//
//  WeeksView.swift
//  MySwiftCalendar
//
//  Created by Zilu.Ma on 16/7/9.
//  Copyright © 2016年 Zilu.Ma. All rights reserved.
//

import UIKit

class WeeksView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let weeks = ["日","一","二","三","四","五","六"]
        
        for index in 0..<7 {
            let originX = 42.5 * CGFloat(index) + 12.5
            let label = UILabel()
            label.frame = CGRectMake(originX, 0, 40, 40)
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.boldSystemFontOfSize(20)
            label.text = weeks[index]
            label.textColor = UIColor.blackColor()
            label.backgroundColor = UIColor.clearColor()
            self.addSubview(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
