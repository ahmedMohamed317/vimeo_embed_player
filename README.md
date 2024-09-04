## Features

A Flutter package that provides an easy way to embed and play Vimeo videos within a WebView.

## Getting started

Embed Vimeo Videos: Easily embed Vimeo videos within your Flutter app.
MIT Licensed: Open-source and free to use in both personal and commercial projects.

## Preview

![vimeo_embed_player](https://github.com/Olosss/vimeo_embed_player/blob/main/assets/player.png?raw=true)
![vimeo_embed_player_actions](https://github.com/Olosss/vimeo_embed_player/blob/main/assets/playerActions.png?raw=true)

## Usage

Import it to your project file

```dart
import 'package:vimeo_embed_player/vimeo_embed_player.dart';
```

Use it in its simplest form, as follows:

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
