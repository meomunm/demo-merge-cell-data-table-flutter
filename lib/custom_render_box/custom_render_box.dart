import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// CustomRenderBox để đo chiều cao của widget
class CustomRenderObjectWidget extends RenderObjectWidget {
  // ...
  final Widget? child;
  final void Function(Size)? onChildSizeChanged;

  const CustomRenderObjectWidget({
    Key? key,
    this.child,
    this.onChildSizeChanged,
  }) : super(key: key);

  @override
  RenderObjectElement createElement() {
    return CustomRenderElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderBox().._widget = this;
  }

  @override
  void updateRenderObject(BuildContext context, CustomRenderBox renderObject) {
    renderObject.._widget = this;
  }
}

class CustomRenderElement extends RenderObjectElement {
  // ...
  Element? _child;

  CustomRenderElement(CustomRenderObjectWidget widget) : super(widget);

  @override
  CustomRenderObjectWidget get widget {
    return super.widget as CustomRenderObjectWidget;
  }

  @override
  CustomRenderBox get renderObject {
    return super.renderObject as CustomRenderBox;
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _child = updateChild(_child, widget.child, null);
  }

  @override
  void update(CustomRenderObjectWidget newWidget) {
    super.update(newWidget);
    _child = updateChild(_child, newWidget.child, null);
  }

  @override
  void unmount() {
    super.unmount();
    _child = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    final child = _child;
    if (child != null) {
      visitor(child);
    }
    super.visitChildren(visitor);
  }

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
    super.forgetChild(child);
  }

  @override
  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    renderObject.insertRenderObjectChild(child, slot);
  }

  @override
  void removeRenderObjectChild(RenderBox child, covariant Object? slot) {
    renderObject.removeRenderObjectChild(child, slot);
  }
}

class CustomRenderBox extends RenderBox {
  RenderBox? _child;
  var _lastSize = Size.zero;
  var _widget = const CustomRenderObjectWidget();

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _child?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    _child?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    final child = _child;
    if (child != null) {
      visitor(child);
    }
    super.visitChildren(visitor);
  }

  @override
  void redepthChildren() {
    final child = _child;
    if (child != null) {
      redepthChild(child);
    }
    super.redepthChildren();
  }

  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    assert(_child == null);
    _child = child;
    adoptChild(child);
  }

  void removeRenderObjectChild(RenderBox child, covariant Object? slot) {
    assert(_child == child);
    _child = null;
    dropChild(child);
  }

  @override
  void performLayout() {
    final child = _child;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = child.size;
    } else {
      size = constraints.smallest;
    }

    if (_lastSize != size) {
      _lastSize = size;
      _widget.onChildSizeChanged?.call(_lastSize);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = _child;
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return _child?.hitTest(result, position: position) == true;
  }
}
