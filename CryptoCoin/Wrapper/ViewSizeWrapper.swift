//
//  ViewWidthWrapper.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import SwiftUI

private struct ViewSizeWrapper: ViewModifier {
    let perform: (CGSize) -> Void
    
    func body(content: Content) -> some View {
        GeometryReader { geometryProxy in
            content
                .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: perform)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

extension View {
    func onReadSize(_ perform: @escaping (CGSize) -> Void) -> some View {
        modifier(ViewSizeWrapper(perform: perform))
    }
    
    @ViewBuilder
    func customBackground<V: View>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View {
        self.background(alignment: alignment, content: content)
    }
}
