//
//  HistoryChart.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

final class HistoryChart: UIView {
    
    private var segments = [[HistoryModel]]()
    private var total = CGFloat()
    
    init() {
        super.init(frame: .zero)
        self.isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        let radius = min(frame.width, frame.height) * 0.5
        let viewCenter = self.getCenter(fromBounds: bounds)
        
        self.configSegmentsColor(viewCenter: viewCenter,
                                 radius: radius,
                                 ctx: ctx)
        self.configChartLabels(viewCenter: viewCenter, radius: radius)
    }
}

extension HistoryChart {
    
    func updateChart(_ chart: [[HistoryModel]]) {
        self.segments = chart
        self.total = self.getTotalSum(chart)
        print(self.total)
        self.setNeedsDisplay()
    }
}

private extension HistoryChart {
    
    func forEachSegment(complition: ([HistoryModel],
                                     _ startAngle: CGFloat,
                                     _ endAngle: CGFloat) -> ()) {
        
        let valueCount = segments.lazy.map { $0.lazy.map { $0.value }.reduce(0, +) }.reduce(0, +)
        
        var startAngle: CGFloat = -.pi * 0.5
        
        for segment in segments {
            let endAngle = startAngle + .pi * 2 * CGFloat(((segment.map { CGFloat($0.value) }.reduce(0, +)) / self.total))
            defer {
                startAngle = endAngle
            }
            
            complition(segment, startAngle, endAngle)
        }
    }
    
    func configChartLabels(viewCenter: CGPoint, radius: CGFloat) {
        self.forEachSegment { segment, startAngle, endAngle in
            let halfAngle = startAngle + (endAngle - startAngle) * 0.5;
            
            var segmentCenter = viewCenter
            if segments.count > 1 {
                segmentCenter = self.projected(by: radius * 0.8,
                                               angle: halfAngle,
                                               center: segmentCenter)
            }
            
            let textString = String(format: "%g", ((segment.lazy.map { CGFloat($0.value) }.reduce(0, +))/self.total * 100).rounded())
            
            let text = "\(textString)%"
            
            let font: UIFont = .systemFont(ofSize: 16)
            
            let attributes = [NSAttributedString.Key.font : font as Any,
                              NSAttributedString.Key.foregroundColor: UIColor.white]
            
            let textRenderSize = text.size(withAttributes: attributes)
            let renderRect = getCGRect(centeredOn: segmentCenter,
                                       size: textRenderSize)
            text.draw(in: renderRect, withAttributes: attributes)
        }
    }
    
    func configSegmentsColor(viewCenter: CGPoint,
                             radius: CGFloat,
                             ctx: CGContext) {
        
        self.forEachSegment { segment, startAngle, endAngle in
            
            let color = ColorConverter.toColor(fromData: segment.first?.color ?? Data())
            
            
            ctx.setFillColor(color?.cgColor ?? UIColor.green.cgColor)
            
            ctx.move(to: viewCenter)
            
            ctx.addArc(center: viewCenter,
                       radius: radius,
                       startAngle: startAngle,
                       endAngle: endAngle,
                       clockwise: false)
            
            ctx.fillPath()
        }
    }
    
    func projected(by value: CGFloat,
                   angle: CGFloat,
                   center: CGPoint) -> CGPoint {
        return CGPoint(x: center.x + value * cos(angle),
                       y: center.y + value * sin(angle))
    }
    
    func getCenter(fromBounds: CGRect) -> CGPoint {
        CGPoint(x: fromBounds.origin.x + fromBounds.size.width * 0.5,
                y: fromBounds.origin.y + fromBounds.size.height * 0.5)
    }
    
    func getCGRect(centeredOn center: CGPoint, size: CGSize) -> CGRect {
        CGRect(origin: CGPoint(x: center.x - size.width * 0.5,
                               y: center.y - size.height * 0.5),
               size: size)
    }
    
    func getTotalSum(_ chart: [[HistoryModel]]) -> CGFloat {
        var total = Int()
        
        for i in 0..<chart.count {
            total += chart[i].lazy.map { $0.value }.reduce(0, +)
        }
        
        return CGFloat(total)
    }
}
