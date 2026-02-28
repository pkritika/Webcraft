import SwiftUI
import WebKit

struct HTMLPreview: UIViewRepresentable {
    let htmlContent: String
    let cssContent: String?
    let jsContent: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.bounces = true
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let combinedHTML = buildFullHTML()
        webView.loadHTMLString(combinedHTML, baseURL: nil)
    }
    
    private func buildFullHTML() -> String {
        // Combine HTML, CSS, and JS into a single document
        let cssBlock = cssContent ?? ""
        let jsBlock = jsContent ?? ""
        
        // Add timestamp to bust WebView cache
        let timestamp = Date().timeIntervalSince1970
        
        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                /* Cache buster: \(timestamp) */
                body {
                    margin: 0;
                    padding: 16px;
                    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                }
                \(cssBlock)
            </style>
        </head>
        <body>
            \(htmlContent)
            <script>
                \(jsBlock)
            </script>
        </body>
        </html>
        """
    }
}

