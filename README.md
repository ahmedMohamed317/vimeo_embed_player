## Features

A Flutter package that provides an easy way to embed and play Vimeo videos within a WebView.

## Getting started

Embed Vimeo Videos: Easily embed Vimeo videos within your Flutter web app using a simple and straightforward API.
MIT Licensed: Open-source and free to use in both personal and commercial projects.

# Preview

## Usage

Import it to your project file

```dart
import 'package:vimeo_embed_player/vimeo_embed_player.dart';
```

```dart
VimeoEmbedPlayer(
  vimeoId: '397912933',
);
```

### Required parameters of VimeoEmbedPlayer
------------
| Parameter      | Description                 |
|----------------|-----------------------------|
| String vimeoId | the id of valid vimeo video |

### Optional parameters of VimeoEmbedPlayer
------------
| Parameter   | Description                                                                                     |
|-------------|-------------------------------------------------------------------------------------------------|
| autoPlay    | The parameter informing whether the video should automatically start playing                    |
