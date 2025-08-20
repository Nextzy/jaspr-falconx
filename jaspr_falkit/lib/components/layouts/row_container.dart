import 'package:jaspr_falkit/lib.dart';

/// A container that arranges its children in a horizontal row.
/// 
/// By default, uses flexbox with row direction and provides
/// common row layout patterns through predefined configurations.
class RowContainer extends Container {
  const RowContainer(
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
    // Flexbox - Row specific defaults
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
    // Row layout presets
    this.spacing,
    this.reverse = false,
    this.centered = false,
    this.spread = false,
    this.spaceBetween = false,
    this.spaceAround = false,
    this.spaceEvenly = false,
    this.startAligned = false,
    this.endAligned = false,
    this.baselineAligned = false,
  }) : super(
          layout: LayoutStyle.div,
        );

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
  
  /// Align items to the baseline
  final bool baselineAligned;

  @override
  LayoutConfig get layoutConfig => RowLayoutConfig(
    reverse: reverse,
    centered: centered,
    spread: spread,
    spaceBetween: spaceBetween,
    spaceAround: spaceAround,
    spaceEvenly: spaceEvenly,
    startAligned: startAligned,
    endAligned: endAligned,
    baselineAligned: baselineAligned,
    spacing: spacing,
  );
}

/// Convenience factory for creating rows with common patterns
class Row {
  /// Create a simple row with optional spacing
  static RowContainer simple(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      RowContainer(
        children,
        key: key,
        spacing: spacing,
      );

  /// Create a centered row
  static RowContainer centered(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      RowContainer(
        children,
        key: key,
        spacing: spacing,
        centered: true,
      );

  /// Create a row with space between items
  static RowContainer spaceBetween(
    List<Component> children, {
    Key? key,
  }) =>
      RowContainer(
        children,
        key: key,
        spaceBetween: true,
      );

  /// Create a row with items at the end
  static RowContainer end(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      RowContainer(
        children,
        key: key,
        spacing: spacing,
        endAligned: true,
      );
}