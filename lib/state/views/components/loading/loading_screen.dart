import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insta_clon_rivrpo/state/views/components/constants/strings.dart';
import 'package:insta_clon_rivrpo/state/views/components/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  static final LoadingScreen _shared = LoadingScreen._sharedInstance();

  factory LoadingScreen() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String message = Strings.loading,
  }) {
    if (_controller?.updateLoadingScreen(message) ?? false) {
      return;
    } else {
      _controller = showOverlay(context: context, message: message);
    }
  }

  void hide() {
    _controller?.closeLoadingScreen();
    _controller = null;
  }

  LoadingScreenController? showOverlay(
      {required BuildContext context, required String message}) {
    final state = Overlay.of(context);

    final textControler = StreamController<String>();
    textControler.add(message);

    final renderBox = context.findRenderObject() as RenderBox;

    final size = renderBox.size;

    final overlay = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(150),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(
            maxWidth: size.width * 0.8,
            maxHeight: size.height * 0.8,
            minWidth: size.width * 0.5,
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<String>(
                          stream: textControler.stream,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data ?? '',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            );
                          }),
                    ]),
              )),
        )),
      );
    });
    state.insert(overlay);

    return LoadingScreenController(closeLoadingScreen: () {
      textControler.close();
      overlay.remove();
      return true;
    }, updateLoadingScreen: (text) {
      textControler.add(text);
      return true;
    });
  }
}
