import 'package:jaspr_falkit/lib.dart';
import 'base/base.dart';

/// A container that arranges its children in a vertical column.
/// 
/// By default, uses flexbox with column direction and provides
/// common column layout patterns through predefined configurations.
class ColumnContainer extends Container {
  const ColumnContainer(
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

/// Convenience factory for creating columns with common patterns
class Column {
  /// Create a simple column with optional spacing
  static ColumnContainer simple(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      ColumnContainer(
        children,
        key: key,
        spacing: spacing,
      );

  /// Create a centered column
  static ColumnContainer centered(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      ColumnContainer(
        children,
        key: key,
        spacing: spacing,
        centered: true,
      );

  /// Create a column with space between items
  static ColumnContainer spaceBetween(
    List<Component> children, {
    Key? key,
    bool fullHeight = true,
  }) =>
      ColumnContainer(
        children,
        key: key,
        spaceBetween: true,
        fullHeight: fullHeight,
      );

  /// Create a full-height column
  static ColumnContainer fullHeight(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      ColumnContainer(
        children,
        key: key,
        spacing: spacing,
        fullHeight: true,
      );
}