import 'package:jaspr_falkit/lib.dart';

/// A container that stacks its children on top of each other.
/// 
/// Uses CSS positioning to layer children, with the first child
/// at the bottom and the last child at the top. Children can be
/// positioned using the PositionedContainer wrapper.
class StackContainer extends Container {
  const StackContainer(
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
    // Stack specific
    this.alignment = StackAlignment.topLeft,
    this.clipOverflow = false,
  }) : super(
          layout: LayoutStyle.div,
        );

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

/// Alignment options for stack children
enum StackAlignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// A container for positioning children within a StackContainer
class PositionedContainer extends Container {
  PositionedContainer(
    super.children, {
    super.key,
    Unit? top,
    Unit? right,
    Unit? bottom,
    Unit? left,
    super.width,
    super.height,
    super.padding,
    super.margin,
    super.zIndex,
    // All other inherited properties
    super.id,
    super.tailwind,
    super.classes,
    super.styles,
    super.attributes,
    super.minWidth,
    super.minHeight,
    super.maxWidth,
    super.maxHeight,
    super.content,
    super.display,
    super.boxSizing,
    super.border,
    super.radius,
    super.outline,
    super.opacity,
    super.visibility,
    super.overflow,
    super.shadow,
    super.cursor,
    super.userSelect,
    super.pointerEvents,
    super.transition,
    super.transform,
    super.flexDirection,
    super.flexWrap,
    super.justifyContent,
    super.alignItems,
    super.gridTemplate,
    super.autoRows,
    super.autoColumns,
    super.gap,
    super.flex,
    super.order,
    super.alignSelf,
    super.gridPlacement,
    super.listStyle,
    super.listImage,
    super.listPosition,
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
    super.backgroundColor,
    super.backgroundImage,
    super.backgroundOrigin,
    super.backgroundPosition,
    super.backgroundAttachment,
    super.backgroundRepeat,
    super.backgroundSize,
    super.backgroundClip,
    Map<String, String>? rawStyle,
  }) : super(
          layout: LayoutStyle.div,
          position: const Position.absolute(),
          rawStyle: {
            if (top != null) 'top': top.value,
            if (right != null) 'right': right.value,
            if (bottom != null) 'bottom': bottom.value,
            if (left != null) 'left': left.value,
            ...?rawStyle,
          },
        );
}

/// Convenience factory for creating stacks with common patterns
class Stack {
  /// Create a simple stack
  static StackContainer simple(
    List<Component> children, {
    Key? key,
  }) =>
      StackContainer(
        children,
        key: key,
      );

  /// Create a centered stack
  static StackContainer centered(
    List<Component> children, {
    Key? key,
  }) =>
      StackContainer(
        children,
        key: key,
        alignment: StackAlignment.center,
      );

  /// Create a stack with clipped overflow
  static StackContainer clipped(
    List<Component> children, {
    StackAlignment alignment = StackAlignment.topLeft,
    Key? key,
  }) =>
      StackContainer(
        children,
        key: key,
        alignment: alignment,
        clipOverflow: true,
      );
}
