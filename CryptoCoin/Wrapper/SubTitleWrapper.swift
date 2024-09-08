//
//  SubTitleWrapper.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import SwiftUI

private struct SubTitleWrapper: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.heavy)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension View {
    func asSubTitle() -> some View {
        modifier(SubTitleWrapper())
    }
}
