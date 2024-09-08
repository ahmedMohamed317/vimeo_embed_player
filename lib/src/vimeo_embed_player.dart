import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VimeoEmbedPlayer extends StatelessWidget {
  const VimeoEmbedPlayer({
    super.key,
    required this.vimeoId,
    this.autoPlay = false,
    required this.authToken, // Add token as a required parameter

  });

  final String vimeoId;
  final bool autoPlay;
  final String authToken; // Bearer token for authentication

  @override
  Widget build(BuildContext context) {
    final url = URLRequest(
      url: Uri.parse(_vimeoPlayer(vimeoId)),
      headers: {
        // Add Bearer token to the headers
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );

    return InAppWebView(
      // initialSettings: InAppWebViewSettings(
      //   useShouldOverrideUrlLoading: true,
      //   mediaPlaybackRequiresUserGesture: false,
      //   allowsInlineMediaPlayback: true,
      // ),
      initialUrlRequest: url,
      shouldOverrideUrlLoading: shouldOverrideUrlLoading,
    );
  }

  String _vimeoPlayer(String videoId) {
    final html = '''
            <html>
              <head>
                <style>
                  body {
                   background-color: lightgray;
                   margin: 0px;
                   }
                   ::-webkit-media-controls {
                      display: none !important;
                    }
                </style>
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
             </head>
             <body>
                <iframe 
                src="${getPath()}" 
                width="100%" height="100%" frameborder="0" allow="fullscreen"
                webkitallowfullscreen mozallowfullscreen allowfullscreen fullscreen></iframe>
             </body>
            </html>
            ''';
    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(html));
    return 'data:text/html;base64,$contentBase64';
  }

  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction,
      ) async {
    if (Platform.isIOS) {
      if (navigationAction.request.url?.toString() == "https://vimeo.com/") {
        return NavigationActionPolicy.CANCEL;
      }

      if (navigationAction.request.url?.toString() == getPath() ||
          navigationAction.request.url?.toString() == _vimeoPlayer(vimeoId)) {
        return NavigationActionPolicy.ALLOW;
      }
    }

    return NavigationActionPolicy.CANCEL;
  }

  String getPath() {
    return "https://player.vimeo.com/video/$vimeoId?h=f9892c138b&autoplay=$autoPlay&loop=1&pip=0";
    // return "https://player.vimeo.com/video/$vimeoId?autoplay=$autoPlay&loop=1&pip=0h=f9892c138b";

  }
}
