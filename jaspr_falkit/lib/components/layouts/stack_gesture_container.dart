import 'package:jaspr_falkit/lib.dart';

/// A stack container with gesture detection capabilities.
/// 
/// Combines layered stack layout with interactive gesture handling.
/// Supports all standard gestures like tap, double tap, long press, hover, etc.
class StackGestureContainer extends GestureContainer {
  const StackGestureContainer(
    super.children, {
    super.key,
    super.id,
    super.tailwind,
    super.classes,
    super.styles,
    super.attributes,
    // Dimensions
    super.width,
    super.height,
    super.minWidth,
    super.minHeight,
    super.maxWidth,
    super.maxHeight,
    // Layout
    super.content,
    super.display,
    super.position,
    super.zIndex,
    // Spacing
    super.padding,
    super.margin,
    // Box Model
    super.boxSizing,
    super.border,
    super.radius,
    super.outline,
    // Visual
    super.opacity,
    super.visibility,
    super.overflow,
    super.shadow,
    // Interaction
    super.cursor,
    super.userSelect,
    super.pointerEvents,
    // Animation
    super.transition,
    super.transform,
    // Flexbox (used for alignment)
    super.flexDirection,
    super.flexWrap,
    super.justifyContent,
    super.alignItems,
    // Grid
    super.gridTemplate,
    super.autoRows,
    super.autoColumns,
    super.gap,
    // Item
    super.flex,
    super.order,
    super.alignSelf,
    super.gridPlacement,
    // List
    super.listStyle,
    super.listImage,
    super.listPosition,
    // Text
    super.color,
    super.textAlign,
    super.fontFamily,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.textDecoration,
    super.textTransform,
    super.textIndent,
    super.letterSpacing,
    super.wordSpacing,
    super.lineHeight,
    super.textShadow,
    super.textOverflow,
    super.whiteSpace,
    // Background
    super.backgroundColor,
    super.backgroundImage,
    super.backgroundOrigin,
    super.backgroundPosition,
    super.backgroundAttachment,
    super.backgroundRepeat,
    super.backgroundSize,
    super.backgroundClip,
    // Raw
    super.rawStyle,
    // Gesture handlers
    super.onTap,
    super.onDoubleTap,
    super.onLongPress,
    super.onTapDown,
    super.onTapUp,
    super.onTapCancel,
    super.onHover,
    super.onEnter,
    super.onExit,
    super.onFocus,
    super.onBlur,
    super.onContextMenu,
    // Stack specific
    this.alignment = StackAlignment.topLeft,
    this.clipOverflow = false,
  }) : super();

  /// How to align the children within the stack
  final StackAlignment alignment;
  
  /// Whether to clip overflow content
  final bool clipOverflow;

  @override
  LayoutConfig get layoutConfig => StackLayoutConfig(
    alignment: alignment,
    clipOverflow: clipOverflow,
  );
}

/// Convenience factory for creating interactive stacks
class StackGesture {
  /// Create a tappable stack
  static StackGestureContainer tappable(
    List<Component> children, {
    required VoidCallback onTap,
    StackAlignment alignment = StackAlignment.topLeft,
    Key? key,
  }) =>
      StackGestureContainer(
        children,
        key: key,
        alignment: alignment,
        onTap: onTap,
        cursor: Cursor.pointer,
      );

  /// Create a hoverable stack
  static StackGestureContainer hoverable(
    List<Component> children, {
    required ValueChanged<bool> onHover,
    StackAlignment alignment = StackAlignment.topLeft,
    Key? key,
  }) =>
      StackGestureContainer(
        children,
        key: key,
        alignment: alignment,
        onHover: onHover,
        cursor: Cursor.pointer,
      );

  /// Create a centered tappable stack
  static StackGestureContainer centeredTappable(
    List<Component> children, {
    required VoidCallback onTap,
    bool clipOverflow = false,
    Key? key,
  }) =>
      StackGestureContainer(
        children,
        key: key,
        alignment: StackAlignment.center,
        clipOverflow: clipOverflow,
        onTap: onTap,
        cursor: Cursor.pointer,
      );
}