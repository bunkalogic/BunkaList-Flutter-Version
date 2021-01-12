import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Shimmer extends StatefulWidget {
  Shimmer({
    @required this.child,
    @required Color baseColor,
    @required Color highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  }) : gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [baseColor, baseColor, highlightColor, baseColor, baseColor],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        );

  final Widget child;
  final Duration duration;
  final Gradient gradient;

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _Shimmer(
        child: widget.child,
        gradient: widget.gradient,
        percent: _controller.value,
      );
}

class _Shimmer extends SingleChildRenderObjectWidget {
  _Shimmer({Widget child, this.gradient, this.percent}) : super(child: child);

  final Gradient gradient;
  final double percent;

  @override
  RenderObject createRenderObject(BuildContext context) => _ShimmerFilter(gradient);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _ShimmerFilter).shiftPercentage = percent;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  _ShimmerFilter(this._gradient);

  final Gradient _gradient;
  double _shiftPercentage = 0.0;

  set shiftPercentage(double newValue) {
    if (_shiftPercentage != newValue) {
      _shiftPercentage = newValue;
      markNeedsPaint();
    }
  }

  @override
  ShaderMaskLayer get layer => super.layer;

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final width = child.size.width;
      final height = child.size.height;
      double dx = _offset(start: -width, end: width * 2, percent: _shiftPercentage);
      double dy = 0.0;
      final rect = Rect.fromLTWH(dx, dy, width, height);

      layer ??= ShaderMaskLayer();
      layer
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer, super.paint, offset);
    }
  }

  double _offset({double start, double end, double percent}) => start + (end - start) * percent;
}