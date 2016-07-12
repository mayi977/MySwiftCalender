//
//  ViewController.swift
//  MySwiftCalendar
//
//  Created by Zilu.Ma on 16/7/6.
//  Copyright © 2016年 Zilu.Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {

    var selectedCell:MyCollectionViewCell?
    
    //判断当前显示的日期是以前,未来,现在
    var last:Bool = false
    var current = false
    var next = false
    
    //现在日期
    var year:Int = 0
    var month:Int = 0
    var day:Int = 0
    
    //选择的日期
    var selectDay = 0
    
    //记录当前三个月的年,月,天数和星期
    var lastMonth = 30
    var lastYear = 0
    var lastCount = 0
    var lastWeek = 0
    var currentMonth = 30
    var currentYear = 0
    var currentCount = 0
    var currentWeek = 0
    var nextMonth = 30
    var nextYear = 0
    var nextCount = 0
    var nextWeek = 0
    
    //日期颜色
    let lastColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    let currentColor = UIColor.whiteColor()
    let nextColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
    var selectColor:UIColor!
    
    //界面控件
    var dateLabel:UILabel!
    var monthBgScrollView:UIScrollView!
    var weekBgScrollView:UIScrollView!
    var lastCollection:UICollectionView!
    var currentCollection:UICollectionView!
    var nextCollection:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initCurrentDate()
        
        initWeeksView()
        initAllCollectionView()
    }
    
    //获取当前日期
    func initCurrentDate() {
        let date = DateClass.getNowDate()
        year = date.year
        month = date.month
        day = date.day
        
        currentYear = year
        currentMonth = month
        selectDay = day
        
        getYearAndMonth()
    }
    
    //计算当前三个月的年月,天数和星期
    func getYearAndMonth() {
        
        let curentDate = DateClass.getYearAndMonth(currentYear, month: currentMonth)
        currentYear = curentDate.year
        currentMonth = curentDate.month
        currentCount = curentDate.count
        currentWeek = curentDate.week
        
        let lastDate = DateClass.getYearAndMonth(currentYear, month: currentMonth - 1)
        lastYear = lastDate.year
        lastMonth = lastDate.month
        lastCount = lastDate.count
        lastWeek = lastDate.week
        
        let nextDate = DateClass.getYearAndMonth(currentYear, month: currentMonth + 1)
        nextYear = nextDate.year
        nextMonth = nextDate.month
        nextCount = nextDate.count
        nextWeek = nextDate.week
        
        //判断以前现在未来
        selectDay = 1
        if currentYear > year {
            last = false
            current = false
            next = true
        }else if currentYear == year{
            if currentMonth > month {
                last = false
                current = false
                next = true
            }else if currentMonth == month{
                last = false
                current = true
                next = false
                
                selectDay = day
            }else{
                last = true
                current = false
                next = false
            }
        }else{
            last = true
            current = false
            next = false
        }
    }
    
    func initWeeksView() {
        
        dateLabel = UILabel()
        dateLabel.frame = CGRectMake(0, 36, 320, 40)
        dateLabel.textAlignment = NSTextAlignment.Center
        dateLabel.font = UIFont.boldSystemFontOfSize(24)
        dateLabel.text = String(currentYear) + "-" + String(currentMonth)
        self.view.addSubview(dateLabel)
        
        let weeksView = WeeksView()
        weeksView.frame = CGRectMake(0, 76, 320, 40)
        weeksView.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(weeksView)
    }
    
    func initAllCollectionView() {
        monthBgScrollView = initBgScrollView(320, height: 480)
        monthBgScrollView.contentOffset = CGPointMake(320, 0)
        
        lastCollection = initCollectionViewOfMonth(y:0)
        monthBgScrollView.addSubview(lastCollection)
        
        currentCollection = initCollectionViewOfMonth(y:320)
        monthBgScrollView.addSubview(currentCollection)
        
        nextCollection = initCollectionViewOfMonth(y:640)
        monthBgScrollView.addSubview(nextCollection)
    }
    
    func initBgScrollView(width:CGFloat,height:CGFloat) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0, 76+40, width, height)
        scrollView.contentSize = CGSizeMake(320*3, 400)
        scrollView.backgroundColor = UIColor.yellowColor()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        return scrollView
    }
    
    func initCollectionViewOfMonth(y originY:CGFloat) -> UICollectionView{
        let collectionView:UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(40, 40);
        //滑动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.minimumLineSpacing = 2.5
        layout.minimumInteritemSpacing = 2.5
        layout.sectionInset = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5)
        
        collectionView = UICollectionView(frame: CGRectMake(10 + originY, 0, 300, 260),collectionViewLayout:layout)
        collectionView.registerClass(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.orangeColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var conut = 0
        if collectionView == lastCollection {
            conut = lastCount + lastWeek - 1
        }else if collectionView == currentCollection {
            conut = currentCount + currentWeek - 1
        }else if collectionView == nextCollection {
            conut = nextCount + nextWeek - 1
        }
        
        return conut
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        cell.backgroundColor = UIColor.purpleColor()
        cell.titleLab.text = ""
        cell.bgImg.image = UIImage(named: "")
        
        if indexPath.item % 2 == 0 {
            cell.dotImg.image = UIImage(named: "")
        }else{
            cell.dotImg.image = UIImage(named: "plan dot")
        }
        
        switch collectionView {
        case lastCollection:
            if indexPath.item >= lastWeek - 1 {
                cell.titleLab.text = String(indexPath.item - lastWeek + 2)
            }
        case currentCollection:
            if indexPath.item >= currentWeek - 1 {
                let time = indexPath.item - currentWeek + 2
                if current {
                    if time < selectDay {
                        cell.titleLab.textColor = lastColor
                    }else if time == selectDay {
                        cell.titleLab.textColor = currentColor
                        selectColor = UIColor.redColor()
                        cell.bgImg.image = UIImage(named: "current selected bg")
                        selectedCell = cell
                    }else{
                        cell.titleLab.textColor = nextColor
                    }
                }else{
                    if last {
                        cell.titleLab.textColor = lastColor
                    }
                    
                    if next {
                        cell.titleLab.textColor = nextColor
                    }
                    
                    if time == selectDay {
                        cell.titleLab.textColor = currentColor
                        cell.bgImg.image = UIImage(named: "current selected bg")
                        selectedCell = cell
                    }
                }
                
                cell.titleLab.text = String(time)
            }
        case nextCollection:
            if indexPath.item >= nextWeek - 1 {
                cell.titleLab.text = String(indexPath.item - nextWeek + 2)
            }
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedCell?.bgImg.image = UIImage(named: "")
        selectedCell?.titleLab.textColor = selectColor
        selectedCell?.selected = false
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MyCollectionViewCell
        cell.selected = true
        selectColor = cell.titleLab.textColor
//        if current && selectDay == day {
//            selectColor = currentColor
//        }else{
//            selectColor = cell.titleLab.textColor
//        }
        
        cell.titleLab.textColor = UIColor.whiteColor()
        selectDay = Int(cell.titleLab.text!)!
        cell.bgImg.image = UIImage(named: "current selected bg")
        if selectedCell == cell {
            return
        }
        
        selectedCell = cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        //左右切换月份
        if scrollView == monthBgScrollView {
            if monthBgScrollView.contentOffset.x == 0 {
                currentMonth -= 1
            }else if monthBgScrollView.contentOffset.x == 640{
                currentMonth += 1
            }
            getYearAndMonth()
            dateLabel.text = String(currentYear) + "-" + String(currentMonth)
            
            monthBgScrollView.contentOffset.x = 320
        }
        
        lastCollection.reloadData()
        currentCollection.reloadData()
        nextCollection.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

