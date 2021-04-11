//
//  EarningSubPresenter.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import Foundation

protocol EarningSubPresenter: GuideDashboardSubPresenter {

    var dateRange: [Date] { get }

    var history: [Double] { get }

    var totalEarnings: Double { get }

}
