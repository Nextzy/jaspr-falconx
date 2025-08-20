import 'package:jaspr_falkit/lib.dart';
import 'base/base.dart';

/// A column container with gesture detection capabilities.
/// 
/// Combines vertical column layout with interactive gesture handling.
/// Supports all standard gestures like tap, double tap, long press, hover, etc.
class ColumnGestureContainer extends GestureContainer {
  const ColumnGestureContainer(
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
    // Flexbox - Column specific defaults
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
    // Column layout presets
    this.spacing,
    this.reverse = false,
    this.centered = false,
    this.spread = false,
    this.spaceBetween = false,
    this.spaceAround = false,
    this.spaceEvenly = false,
    this.startAligned = false,
    this.endAligned = false,
    this.stretch = false,
    this.fullHeight = false,
  }) : super();

  /// Spacing between children (uses gap)
  final Unit? spacing;
  
  /// Reverse the order of children
  final bool reverse;
  
  /// Center children both horizontally and vertically
  final bool centered;
  
  /// Spread children across available space
  final bool spread;
  
  /// Space between children (no space at edges)
  final bool spaceBetween;
  
  /// Space around children (half space at edges)
  final bool spaceAround;
  
  /// Space evenly between and around children
  final bool spaceEvenly;
  
  /// Align items to the start of the cross axis
  final bool startAligned;
  
  /// Align items to the end of the cross axis
  final bool endAligned;
  
  /// Stretch items to fill the cross axis
  final bool stretch;
  
  /// Make the column take full viewport height
  final bool fullHeight;

  @override
  LayoutConfig get layoutConfig => ColumnLayoutConfig(
    reverse: reverse,
    centered: centered,
    spread: spread,
    spaceBetween: spaceBetween,
    spaceAround: spaceAround,
    spaceEvenly: spaceEvenly,
    startAligned: startAligned,
    endAligned: endAligned,
    stretch: stretch,
    fullHeight: fullHeight,
    spacing: spacing,
  );
}

/// Convenience factory for creating interactive columns
class ColumnGesture {
  /// Create a tappable column
  static ColumnGestureContainer tappable(
    List<Component> children, {
    required VoidCallback onTap,
    Unit? spacing,
    Key? key,
  }) =>
      ColumnGestureContainer(
        children,
        key: key,
        spacing: spacing,
        onTap: onTap,
        cursor: Cursor.pointer,
      );

  /// Create a hoverable column
  static ColumnGestureContainer hoverable(
    List<Component> children, {
    required ValueChanged<bool> onHover,
    Unit? spacing,
    Key? key,
  }) =>
      ColumnGestureContainer(
        children,
        key: key,
        spacing: spacing,
        onHover: onHover,
        cursor: Cursor.pointer,
      );

  /// Create a full-height tappable column
  static ColumnGestureContainer fullHeightTappable(
    List<Component> children, {
    required VoidCallback onTap,
    Unit? spacing,
    Key? key,
  }) =>
      ColumnGestureContainer(
        children,
        key: key,
        spacing: spacing,
        fullHeight: true,
        onTap: onTap,
        cursor: Cursor.pointer,
      );
}