import SwiftUI
import WebKit

struct HTMLPreview: UIViewRepresentable {
    let htmlContent: String
    let cssContent: String?
    let jsContent: String?

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.javaScriptEnabled = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.bounces = true
        webView.isOpaque = false
        webView.backgroundColor = .white

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let combinedHTML = buildFullHTML()

        // Force reload every time to prevent caching issues
        webView.loadHTMLString(combinedHTML, baseURL: nil)
    }
    
    private func buildFullHTML() -> String {
        let cssBlock = cssContent ?? ""
        let jsBlock = jsContent ?? ""

        // Add timestamp to bust WebView cache
        let timestamp = Date().timeIntervalSince1970

        // If the HTML is already a full document, handle it directly
        // to avoid double-wrapping (which renders raw tags as text in <body>)
        let lowerHTML = htmlContent.lowercased()
        if lowerHTML.contains("<html") {
            var doc = htmlContent

            // Inject user CSS before </head> if we have any
            if !cssBlock.isEmpty, let headCloseRange = doc.lowercased().range(of: "</head>") {
                let styleTag = "\n<style>/* Cache buster: \(timestamp) */\n\(cssBlock)\n</style>\n"
                doc.insert(contentsOf: styleTag, at: headCloseRange.lowerBound)
            }

            // Inject JS before </body> if we have any
            if !jsBlock.isEmpty, let bodyCloseRange = doc.lowercased().range(of: "</body>") {
                let scriptTag = "\n<script>\n\(jsBlock)\n</script>\n"
                doc.insert(contentsOf: scriptTag, at: bodyCloseRange.lowerBound)
            }

            return doc
        }

        // ── Partial HTML (body content only) ── build a full wrapper document ──

        // Check if HTML content is empty - show helpful message
        let bodyContent: String
        if htmlContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            bodyContent = """
            <div style="padding: 40px; text-align: center; font-family: -apple-system, sans-serif;">
                <h2 style="color: #666;">No HTML content</h2>
                <p style="color: #999;">Click the HTML tab above and make sure there's code there.</p>
                <p style="color: #999; font-size: 14px;">If the HTML tab is empty, click the Reset button (↻) in the top right.</p>
            </div>
            """
        } else {
            bodyContent = htmlContent
        }

        // Build the complete HTML document
        var html = "<!DOCTYPE html>\n"
        html += "<html>\n"
        html += "<head>\n"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
        html += "<meta charset=\"UTF-8\">\n"
        html += "<style>\n"
        html += "/* Cache buster: \(timestamp) */\n"
        html += "* { box-sizing: border-box; }\n"
        html += "body { margin: 0; padding: 0; }\n"
        html += "/* User CSS starts here */\n"
        html += cssBlock
        html += "\n</style>\n"
        html += "</head>\n"
        html += "<body>\n"
        html += bodyContent
        html += "\n"
        if !jsBlock.isEmpty {
            html += "<script>\n"
            html += jsBlock
            html += "\n</script>\n"
        }
        html += "</body>\n"
        html += "</html>"

        return html
    }
}

