import SwiftUI
struct CodeEditor: View {
    @Binding var code: String
    let language: String
    var body: some View {
        TextEditor(text: $code).font(.system(.body, design: .monospaced)).padding(4).background(Color.gray.opacity(0.05)).cornerRadius(8).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3), lineWidth: 1))
    }
}
