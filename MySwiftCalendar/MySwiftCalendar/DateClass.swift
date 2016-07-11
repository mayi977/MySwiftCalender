//
//  DateClass.swift
//  MySwiftCalendar
//
//  Created by Zilu.Ma on 16/7/8.
//  Copyright © 2016年 Zilu.Ma. All rights reserved.
//

import UIKit

class DateClass {

    //得到当前年,月,日
    static func getNowDate() -> (year:Int,month:Int,day:Int){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = dateFormatter.stringFromDate(NSDate())
        let array = string.componentsSeparatedByString("-")
        
        return (Int(array[0])!,Int(array[1])!,Int(array[2])!)
    }
    
    //根据年月得到某月有几天,第一天是周几
    static func getCountOfDaysInMonth(year year:Int,month:Int) -> (count:Int,week:Int){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date
            = dateFormatter.dateFromString(String(year)+"-"+String(month))
        
        let calender = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)
        let range = calender?.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: date!)
        
        let comps = calender?.components(NSCalendarUnit.Weekday, fromDate: date!)
        let week = comps?.weekday
        
        return ((range?.length)!,week!)
    }
    
    static func getYearAndMonth(year:Int,month:Int) -> (year:Int,month:Int,count:Int,week:Int){
        
        var y = year
        var m = month
        if month > 12 {
            m = 1
            y += 1
        }else if month <= 0 {
            m = 12
            y -= 1
        }
        
        let countOfMonth = getCountOfDaysInMonth(year: y, month: m)
        
        return (y,m,countOfMonth.count,countOfMonth.week)
    }
    
    static func getNumber(number:Int) -> String {
        if number >= 10 {
            return String(number)
        }else{
            return "0" + String(number)
        }
    }
}


