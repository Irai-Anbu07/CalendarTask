//
//  calendarModels.swift
//  calendar
//
//  Created by iraiAnbu on 30/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CalendarVC
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
    }
    struct Response
    {
        var days:[Day]?
        var numberOfWeeksinBaseDate:Int?
        var baseDate:Date?
    }
    struct ViewModel
    {
        var days:[Day]?
        var numberOfWeeksinBaseDate:Int?
        var baseDate:Date?
    }
  }
}
