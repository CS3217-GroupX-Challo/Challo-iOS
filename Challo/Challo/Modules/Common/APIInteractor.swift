//
//  APIInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

protocol APIInteractor {
    func convertJSONDoubleValueToDouble(_ value: Any?, defaultValue: Double) -> Double
    func convertJSONIntValueToInt(_ value: Any?, defaultValue: Int) -> Int
}

extension APIInteractor {
    func convertJSONDoubleValueToDouble(_ value: Any?, defaultValue: Double = 0) -> Double {
        Double(value as? String ?? "0") ?? defaultValue
    }
    
    func convertJSONIntValueToInt(_ value: Any?, defaultValue: Int = 0) -> Int {
        value as? Int ?? defaultValue
    }
}
