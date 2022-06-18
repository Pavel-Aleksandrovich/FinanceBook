//
//  PieChartView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

final class PieChart: UIView {
    
    private var segments = [ChartDTO]()
    private var total = CGFloat()
    
    private var segmentLabelFont: UIFont = .systemFont(ofSize: 15)
    
    private let paragraphStyle: NSParagraphStyle = {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        guard let style = style.copy() as? NSParagraphStyle else { return NSParagraphStyle() }
        return style
    }()
    
    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .paragraphStyle: self.paragraphStyle, .font: self.segmentLabelFont
    ]
    
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
        let viewCenter = bounds.center
        
        self.configSegmentsColor(viewCenter: viewCenter,
                                 radius: radius,
                                 ctx: ctx)
        self.configChartLabels(viewCenter: viewCenter, radius: radius)
    }
}

extension PieChart {
    
    func updateChart(_ chart: [ChartDTO]) {
        self.segments = chart
        self.total = self.getTotalSum(chart)
        self.setNeedsDisplay()
    }
    
    func getTotalSum(_ chart: [ChartDTO]) -> CGFloat {
        var total = CGFloat()
        
        for i in 0..<chart.count {
            total += chart[i].amount
        }
        
        return total
    }
}

private extension PieChart {
    
    func forEachSegment(complition: (ChartDTO, _ startAngle: CGFloat, _ endAngle: CGFloat) -> ()) {
        
        let valueCount = segments.lazy.map { $0.amount }.reduce(0, +)
        
        var startAngle: CGFloat = -.pi * 0.5
        
        for segment in segments {
            let endAngle = startAngle + .pi * 2 * CGFloat((segment.amount / valueCount))
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
                segmentCenter = segmentCenter
                    .projected(by: radius * 0.8, angle: halfAngle)
            }
            let textString = String(format: "%g", (segment.amount/self.total * 100).rounded())
            let text = "\(textString)%"
            let textRenderSize = text.size(withAttributes: textAttributes)
            let renderRect = CGRect(centeredOn: segmentCenter,
                                    size: textRenderSize)
            text.draw(in: renderRect, withAttributes: textAttributes)
        }
    }
    
    func configSegmentsColor(viewCenter: CGPoint,
                             radius: CGFloat,
                             ctx: CGContext) {
        
        self.forEachSegment { segment, startAngle, endAngle in
            
            let color = ColorConverter.toColor(fromData: segment.color)
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
}

extension CGRect {
    
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x - size.width * 0.5,
                                  y: center.y - size.height * 0.5),
                  size: size)
    }
    
    var center: CGPoint {
        return CGPoint(x: origin.x + size.width * 0.5,
                       y: origin.y + size.height * 0.5)
    }
}

extension CGPoint {
    
    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        
        return CGPoint(x: x + value * cos(angle),
                       y: y + value * sin(angle))
    }
}
