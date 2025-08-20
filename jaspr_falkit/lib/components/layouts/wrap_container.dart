import 'package:jaspr_falkit/lib.dart';
import 'base/base.dart';

/// A container that wraps its children to the next line when they exceed
/// the available width.
/// 
/// Uses flexbox with wrap enabled to create responsive layouts that
/// automatically adjust to available space. Ideal for tag lists, chip groups,
/// or responsive grids.
class WrapContainer extends Container {
  const WrapContainer(
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
  }) : super(
          layout: LayoutStyle.div,
        );

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

/// Direction for wrapping
enum WrapDirection {
  horizontal,
  vertical,
}

/// Alignment along the main axis
enum WrapAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

/// Alignment of lines
enum WrapRunAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  stretch,
}

/// Alignment along the cross axis
enum WrapCrossAlignment {
  start,
  end,
  center,
  stretch,
  baseline,
}

/// Convenience factory for creating wraps with common patterns
class Wrap {
  /// Create a simple wrap
  static WrapContainer simple(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      WrapContainer(
        children,
        key: key,
        spacing: spacing,
      );

  /// Create a centered wrap
  static WrapContainer centered(
    List<Component> children, {
    Unit? spacing,
    Key? key,
  }) =>
      WrapContainer(
        children,
        key: key,
        spacing: spacing,
        centered: true,
      );

  /// Create a wrap with space between items
  static WrapContainer spaceBetween(
    List<Component> children, {
    Unit? runSpacing,
    Key? key,
  }) =>
      WrapContainer(
        children,
        key: key,
        spaceBetween: true,
        runSpacing: runSpacing,
      );

  /// Create a vertical wrap
  static WrapContainer vertical(
    List<Component> children, {
    Unit? spacing,
    Unit? runSpacing,
    Key? key,
  }) =>
      WrapContainer(
        children,
        key: key,
        direction: WrapDirection.vertical,
        spacing: spacing,
        runSpacing: runSpacing,
      );
}