//
//  EnhancedCodeEditor.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

struct EnhancedCodeEditor: View {
    @Binding var htmlCode: String
    @Binding var cssCode: String
    @Binding var jsCode: String
    @Binding var selectedLanguage: CodeLanguage
    
    var body: some View {
        VStack(spacing: 0) {
            CodeEditorTabs(
                selectedLanguage: $selectedLanguage,
                htmlHasCode: !htmlCode.isEmpty,
                cssHasCode: !cssCode.isEmpty,
                jsHasCode: !jsCode.isEmpty
            )
            
            GeometryReader { geometry in
                ScrollView {
                    SyntaxTextView(text: currentCodeBinding, language: selectedLanguage)
                        .frame(minHeight: geometry.size.height)
                        .padding(8)
                }
            }
            .background(Color(hex: "0D1117"))
        }
    }
    
    private var currentCodeBinding: Binding<String> {
        switch selectedLanguage {
        case .html:
            return $htmlCode
        case .css:
            return $cssCode
        case .javascript:
            return $jsCode
        }
    }
}
