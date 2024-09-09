//
//  HighlightTextWrapper.swift
//  CryptoCoin
//
//  Created by 아라 on 9/9/24.
//

import SwiftUI

private struct HighlightTextWrapper: ViewModifier {
    let original: String
    let target: String
    
    func body(content: Content) -> some View {
        let lowercasedOriginal = original.lowercased()
        let lowercasedTarget = target.lowercased()
        
        if let coloredRange = lowercasedOriginal.range(of: lowercasedTarget) {
            let beforeRange = original[..<coloredRange.lowerBound]
            let coloredText = original[coloredRange]
            let afterRange = original[coloredRange.upperBound...]
            
            return Text(beforeRange)
                .foregroundColor(.black)
            + Text(coloredText)
                .foregroundColor(.purple)
            + Text(afterRange)
                .foregroundColor(.black)
        } else {
            return Text(original)
                .foregroundColor(.black)
        }
    }
}

extension View {
    func asHighlightText(original: String, target: String) -> some View {
        modifier(HighlightTextWrapper(original: original, target: target))
    }
}
