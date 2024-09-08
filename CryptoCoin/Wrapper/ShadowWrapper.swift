//
//  ShadowWrapper.swift
//  CryptoCoin
//
//  Created by 아라 on 9/9/24.
//

import SwiftUI

private struct ShadowWrapper: ViewModifier {
    let radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray.opacity(0.1), radius: radius)
    }
}

extension View {
    func asShdowShape(radius: CGFloat) -> some View {
        modifier(ShadowWrapper(radius: radius))
    }
}
