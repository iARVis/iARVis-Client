//
//  ChartProxy+PositionWithJSON.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/16.
//

import Foundation
import Charts
import SwiftyJSON

@available(iOS 16, *)
extension ChartProxy {
    func position(at valuePoint: (x: JSON, y: JSON)) -> CGPoint? {
        if let xPoint = position(atX: valuePoint.x),
           let yPoint = position(atY: valuePoint.y) {
            return CGPoint(x: xPoint, y: yPoint)
        }
        return nil
    }

    func position(atX x: JSON) -> CGFloat? {
        if let intValue = x.strictInt {
            return position(forX: intValue)
        } else if let doubleValue = x.strictDouble {
            return position(forX: doubleValue)
        } else if let dateValue = x.date {
            return position(forX: dateValue)
        } else if let stringValue = x.string {
            return position(forX: stringValue)
        }
        return nil
    }

    func position(atY y: JSON) -> CGFloat? {
        if let intValue = y.strictInt {
            return position(forY: intValue)
        } else if let doubleValue = y.strictDouble {
            return position(forY: doubleValue)
        } else if let dateValue = y.date {
            return position(forY: dateValue)
        } else if let stringValue = y.string {
            return position(forY: stringValue)
        }
        return nil
    }
    
    func positionRange(atX x: JSON) -> ClosedRange<CGFloat>? {
        if let intValue = x.strictInt {
            return positionRange(forX: intValue)
        } else if let doubleValue = x.strictDouble {
            return positionRange(forX: doubleValue)
        } else if let dateValue = x.date {
            return positionRange(forX: dateValue)
        } else if let stringValue = x.string {
            return positionRange(forX: stringValue)
        }
        return nil
    }
    
    func positionRange(atY y: JSON) -> ClosedRange<CGFloat>? {
        if let intValue = y.strictInt {
            return positionRange(forY: intValue)
        } else if let doubleValue = y.strictDouble {
            return positionRange(forY: doubleValue)
        } else if let dateValue = y.date {
            return positionRange(forY: dateValue)
        } else if let stringValue = y.string {
            return positionRange(forY: stringValue)
        }
        return nil
    }
}
