import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VimeoEmbedPlayer extends StatelessWidget {
  final String vimeoId;
  final bool autoPlay;

  const VimeoEmbedPlayer({
    super.key,
    required this.vimeoId,
    this.autoPlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final url = URLRequest(url: Uri.parse(_vimeoPlayer(vimeoId)));

    return InAppWebView(
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ),
      ),
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
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(html));
    return 'data:text/html;base64,$contentBase64';
  }

  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction,
      ) async {

    if(Platform.isIOS){
      if(navigationAction.request.url?.toString() == "https://vimeo.com/"){
        return NavigationActionPolicy.CANCEL;
      }

      if(navigationAction.request.url?.toString() == getPath() || navigationAction.request.url?.toString() == _vimeoPlayer(vimeoId)){
        return NavigationActionPolicy.ALLOW;
      }
    }

    return NavigationActionPolicy.CANCEL;
  }

  String getPath(){
    return "https://player.vimeo.com/video/$vimeoId?autoplay=$autoPlay&loop=1&pip=0";
  }
}

