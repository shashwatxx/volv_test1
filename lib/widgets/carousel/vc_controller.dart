import 'dart:async';

import 'package:flutter/material.dart';
import 'package:volv_testi/utils/utils.dart';

import 'c_state.dart';

abstract class VolvCarouselController {
  Future<void> nextPage({Duration? duration, Curve? curve});

  Future<void> previousPage({Duration? duration, Curve? curve});

  Future<void> animateToPage(int page, {Duration? duration, Curve? curve});

  factory VolvCarouselController() => VolvCarouselControllerImpl();
}

class VolvCarouselControllerImpl implements VolvCarouselController {
  final Completer _readyCompleter = Completer();

  VolvCarouselState? _state;

  set state(VolvCarouselState? state) {
    _state = state;
    if (!_readyCompleter.isCompleted) {
      _readyCompleter.complete();
    }
  }

  bool get ready => _state != null;

  Future get onReady => _readyCompleter.future;

  /// Animates the controlled [CarouselSlider] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> nextPage(
      {Duration? duration = const Duration(milliseconds: 300),
      Curve? curve = Curves.linear}) async {
    await _state!.pageController!.nextPage(duration: duration!, curve: curve!);
  }

  /// Animates the controlled [CarouselSlider] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> previousPage(
      {Duration? duration = const Duration(milliseconds: 300),
      Curve? curve = Curves.linear}) async {
    await _state!.pageController!
        .previousPage(duration: duration!, curve: curve!);
  }

  /// Animates the controlled [CarouselSlider] from the current page to the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> animateToPage(int page,
      {Duration? duration = const Duration(milliseconds: 300),
      Curve? curve = Curves.linear}) async {
    final index = Utils.getRealIndex(_state!.pageController!.page!.toInt(),
        _state!.realPage - _state!.initialPage, _state!.itemCount);

    await _state!.pageController!.animateToPage(
        _state!.pageController!.page!.toInt() + page - index,
        duration: duration!,
        curve: curve!);
  }
}
