import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// A widget that embeds a Vimeo video player in a Flutter app.
///
/// The `VimeoEmbedPlayer` widget uses the Vimeo video ID to load and display
/// a video from Vimeo. It also provides an option to start the video automatically
/// when the widget is built.
///
/// Example usage:
///
/// ```dart
/// VimeoEmbedPlayer(
///   vimeoId: '397912933',
///   autoPlay: true,
/// )
/// ```
///
class VimeoEmbedPlayer extends StatelessWidget {
  /// Creates a [VimeoEmbedPlayer] widget.
  ///
  /// The [vimeoId] parameter is required and must be provided. It specifies the
  /// ID of the Vimeo video to be embedded. The [autoPlay] parameter is optional
  /// and defaults to `false`. If set to `true`, the video will start playing
  /// automatically when the widget is loaded.
  ///
  /// Example:
  ///
  /// ```dart
  /// VimeoEmbedPlayer(
  ///   vimeoId: '397912933',
  ///   autoPlay: true,
  /// )
  /// ```
  ///

  const VimeoEmbedPlayer({
    super.key,
    required this.vimeoId,
    this.autoPlay = false,
  });

  /// The Vimeo video ID to be embedded in the player.
  ///
  /// This is a required parameter. It should be a valid Vimeo video ID.
  final String vimeoId;

  /// Whether to automatically start playing the video.
  ///
  /// Defaults to `false`.
  final bool autoPlay;

  @override
  Widget build(BuildContext context) {
    final url = URLRequest(url: Uri.parse(_vimeoPlayer(vimeoId)));

    return InAppWebView(
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
    return "https://player.vimeo.com/video/$vimeoId?autoplay=$autoPlay&loop=1&pip=0";
  }
}
