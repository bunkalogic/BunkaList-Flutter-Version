import 'package:bunkalist/src/core/theme/app_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]) : super(props);
}

class ThemeChanged extends ThemeEvent{
  
  final Apptheme theme;

  ThemeChanged({
    @required this.theme,
  }): super([theme]);
  
}