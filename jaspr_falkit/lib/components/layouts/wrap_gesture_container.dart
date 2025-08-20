import 'package:jaspr_falkit/lib.dart';
import 'base/base.dart';

/// A wrap container with gesture detection capabilities.
/// 
/// Combines wrapping layout with interactive gesture handling.
/// Supports all standard gestures like tap, double tap, long press, hover, etc.
class WrapGestureContainer extends GestureContainer {
  const WrapGestureContainer(
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
    // Flexbox - Wrap specific
    super.flexDirection,
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
    // Wrap specific
    this.spacing,
    this.runSpacing,
    this.direction = WrapDirection.horizontal,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapRunAlignment.start,
    this.crossAlignment = WrapCrossAlignment.start,
    this.reverse = false,
    this.centered = false,
    this.spaceBetween = false,
    this.spaceAround = false,
    this.spaceEvenly = false,
  }) : super();

  /// Spacing between items in the same line
  final Unit? spacing;
  
  /// Spacing between lines
  final Unit? runSpacing;
  
  /// The direction to wrap (horizontal or vertical)
  final WrapDirection direction;
  
  /// How to align items along the main axis
  final WrapAlignment alignment;
  
  /// How to align lines
  final WrapRunAlignment runAlignment;
  
  /// How to align items along the cross axis
  final WrapCrossAlignment crossAlignment;
  
  /// Whether to reverse the order
  final bool reverse;
  
  /// Center all items
  final bool centered;
  
  /// Space between items
  final bool spaceBetween;
  
  /// Space around items
  final bool spaceAround;
  
  /// Space evenly between items
  final bool spaceEvenly;

  @override
  LayoutConfig get layoutConfig => WrapLayoutConfig(
    direction: direction,
    alignment: alignment,
    runAlignment: runAlignment,
    crossAlignment: crossAlignment,
    reverse: reverse,
    centered: centered,
    spaceBetween: spaceBetween,
    spaceAround: spaceAround,
    spaceEvenly: spaceEvenly,
    spacing: spacing,
    runSpacing: runSpacing,
  );
}

/// Convenience factory for creating interactive wraps
class WrapGesture {
  /// Create a tappable wrap
  static WrapGestureContainer tappable(
    List<Component> children, {
    required VoidCallback onTap,
    Unit? spacing,
    Key? key,
  }) =>
      WrapGestureContainer(
        children,
        key: key,
        spacing: spacing,
        onTap: onTap,
        cursor: Cursor.pointer,
      );

  /// Create a hoverable wrap
  static WrapGestureContainer hoverable(
    List<Component> children, {
    required ValueChanged<bool> onHover,
    Unit? spacing,
    Key? key,
  }) =>
      WrapGestureContainer(
        children,
        key: key,
        spacing: spacing,
        onHover: onHover,
        cursor: Cursor.pointer,
      );

  /// Create a centered tappable wrap
  static WrapGestureContainer centeredTappable(
    List<Component> children, {
    required VoidCallback onTap,
    Unit? spacing,
    Unit? runSpacing,
    Key? key,
  }) =>
      WrapGestureContainer(
        children,
        key: key,
        spacing: spacing,
        runSpacing: runSpacing,
        centered: true,
        onTap: onTap,
        cursor: Cursor.pointer,
      );
}