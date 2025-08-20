import 'package:jaspr_falkit/lib.dart';

/// Configuration for layout-specific behavior
abstract class LayoutConfig {
  const LayoutConfig();
  /// Apply layout-specific styles
  Styles applyLayoutStyles(Styles baseStyles);
  
  /// Apply layout-specific classes
  String applyLayoutClasses(String baseClasses);
  
  /// Get display type for this layout
  Display? getDisplay();
  
  /// Get flex direction for this layout
  FlexDirection? getFlexDirection();
  
  /// Get flex wrap for this layout
  FlexWrap? getFlexWrap();
  
  /// Get justify content for this layout
  JustifyContent? getJustifyContent();
  
  /// Get align items for this layout
  AlignItems? getAlignItems();
  
  /// Get additional raw styles for this layout
  Map<String, String> getAdditionalRawStyles();
}

/// Row layout configuration
class RowLayoutConfig extends LayoutConfig {
  final bool reverse;
  final bool centered;
  final bool spread;
  final bool spaceBetween;
  final bool spaceAround;
  final bool spaceEvenly;
  final bool startAligned;
  final bool endAligned;
  final bool baselineAligned;
  final Unit? spacing;

  const RowLayoutConfig({
    this.reverse = false,
    this.centered = false,
    this.spread = false,
    this.spaceBetween = false,
    this.spaceAround = false,
    this.spaceEvenly = false,
    this.startAligned = false,
    this.endAligned = false,
    this.baselineAligned = false,
    this.spacing,
  });

  @override
  Display? getDisplay() => Display.flex;

  @override
  FlexDirection? getFlexDirection() =>
      reverse ? FlexDirection.rowReverse : FlexDirection.row;

  @override
  FlexWrap? getFlexWrap() => FlexWrap.nowrap;

  @override
  JustifyContent? getJustifyContent() {
    if (centered || spread || spaceBetween) return JustifyContent.spaceBetween;
    if (spaceAround) return JustifyContent.spaceAround;
    if (spaceEvenly) return JustifyContent.spaceEvenly;
    if (endAligned) return JustifyContent.end;
    if (startAligned) return JustifyContent.start;
    return JustifyContent.start;
  }

  @override
  AlignItems? getAlignItems() {
    if (centered) return AlignItems.center;
    if (baselineAligned) return AlignItems.baseline;
    if (startAligned) return AlignItems.start;
    if (endAligned) return AlignItems.end;
    return AlignItems.stretch;
  }

  @override
  Map<String, String> getAdditionalRawStyles() => {};

  @override
  Styles applyLayoutStyles(Styles baseStyles) {
    return Styles(
      display: getDisplay(),
      flexDirection: getFlexDirection(),
      flexWrap: getFlexWrap(),
      justifyContent: getJustifyContent(),
      alignItems: getAlignItems(),
      gap: spacing != null ? Gap(column: spacing, row: spacing) : null,
    ).combine(baseStyles);
  }

  @override
  String applyLayoutClasses(String baseClasses) => baseClasses;
}

/// Column layout configuration
class ColumnLayoutConfig extends LayoutConfig {
  final bool reverse;
  final bool centered;
  final bool spread;
  final bool spaceBetween;
  final bool spaceAround;
  final bool spaceEvenly;
  final bool startAligned;
  final bool endAligned;
  final bool stretch;
  final bool fullHeight;
  final Unit? spacing;

  const ColumnLayoutConfig({
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
    this.spacing,
  });

  @override
  Display? getDisplay() => Display.flex;

  @override
  FlexDirection? getFlexDirection() =>
      reverse ? FlexDirection.columnReverse : FlexDirection.column;

  @override
  FlexWrap? getFlexWrap() => FlexWrap.nowrap;

  @override
  JustifyContent? getJustifyContent() {
    if (centered || spread || spaceBetween) return JustifyContent.spaceBetween;
    if (spaceAround) return JustifyContent.spaceAround;
    if (spaceEvenly) return JustifyContent.spaceEvenly;
    if (endAligned) return JustifyContent.end;
    if (startAligned) return JustifyContent.start;
    return JustifyContent.start;
  }

  @override
  AlignItems? getAlignItems() {
    if (centered) return AlignItems.center;
    if (stretch) return AlignItems.stretch;
    if (startAligned) return AlignItems.start;
    if (endAligned) return AlignItems.end;
    return AlignItems.stretch;
  }

  @override
  Map<String, String> getAdditionalRawStyles() => {};

  @override
  Styles applyLayoutStyles(Styles baseStyles) {
    final layoutStyles = Styles(
      display: getDisplay(),
      flexDirection: getFlexDirection(),
      flexWrap: getFlexWrap(),
      justifyContent: getJustifyContent(),
      alignItems: getAlignItems(),
      gap: spacing != null ? Gap(column: spacing, row: spacing) : null,
      height: fullHeight ? const Unit.percent(100) : null,
    );
    return layoutStyles.combine(baseStyles);
  }

  @override
  String applyLayoutClasses(String baseClasses) => baseClasses;
}

/// Stack layout configuration
class StackLayoutConfig extends LayoutConfig {
  final StackAlignment alignment;
  final bool clipOverflow;

  const StackLayoutConfig({
    this.alignment = StackAlignment.topLeft,
    this.clipOverflow = false,
  });

  @override
  Display? getDisplay() {
    return switch (alignment) {
      StackAlignment.topLeft => null,
      _ => Display.flex,
    };
  }

  @override
  FlexDirection? getFlexDirection() => null;

  @override
  FlexWrap? getFlexWrap() => null;

  @override
  JustifyContent? getJustifyContent() {
    return switch (alignment) {
      StackAlignment.topLeft ||
      StackAlignment.centerLeft ||
      StackAlignment.bottomLeft => null,
      StackAlignment.topCenter ||
      StackAlignment.center ||
      StackAlignment.bottomCenter => JustifyContent.center,
      StackAlignment.topRight ||
      StackAlignment.centerRight ||
      StackAlignment.bottomRight => JustifyContent.end,
    };
  }

  @override
  AlignItems? getAlignItems() {
    return switch (alignment) {
      StackAlignment.topLeft ||
      StackAlignment.topCenter ||
      StackAlignment.topRight => null,
      StackAlignment.centerLeft ||
      StackAlignment.center ||
      StackAlignment.centerRight => AlignItems.center,
      StackAlignment.bottomLeft ||
      StackAlignment.bottomCenter ||
      StackAlignment.bottomRight => AlignItems.end,
    };
  }

  @override
  Map<String, String> getAdditionalRawStyles() => {};

  @override
  Styles applyLayoutStyles(Styles baseStyles) {
    final layoutStyles = Styles(
      display: getDisplay(),
      position: const Position.relative(),
      justifyContent: getJustifyContent(),
      alignItems: getAlignItems(),
      overflow: clipOverflow ? Overflow.hidden : null,
    );
    return layoutStyles.combine(baseStyles);
  }

  @override
  String applyLayoutClasses(String baseClasses) => baseClasses;
}

/// Wrap layout configuration
class WrapLayoutConfig extends LayoutConfig {
  final WrapDirection direction;
  final WrapAlignment alignment;
  final WrapRunAlignment runAlignment;
  final WrapCrossAlignment crossAlignment;
  final bool reverse;
  final bool centered;
  final bool spaceBetween;
  final bool spaceAround;
  final bool spaceEvenly;
  final Unit? spacing;
  final Unit? runSpacing;

  const WrapLayoutConfig({
    this.direction = WrapDirection.horizontal,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapRunAlignment.start,
    this.crossAlignment = WrapCrossAlignment.start,
    this.reverse = false,
    this.centered = false,
    this.spaceBetween = false,
    this.spaceAround = false,
    this.spaceEvenly = false,
    this.spacing,
    this.runSpacing,
  });

  @override
  Display? getDisplay() => Display.flex;

  @override
  FlexDirection? getFlexDirection() {
    return switch ((direction, reverse)) {
      (WrapDirection.horizontal, false) => FlexDirection.row,
      (WrapDirection.horizontal, true) => FlexDirection.rowReverse,
      (WrapDirection.vertical, false) => FlexDirection.column,
      (WrapDirection.vertical, true) => FlexDirection.columnReverse,
    };
  }

  @override
  FlexWrap? getFlexWrap() => FlexWrap.wrap;

  @override
  JustifyContent? getJustifyContent() {
    if (centered) return JustifyContent.center;
    if (spaceBetween) return JustifyContent.spaceBetween;
    if (spaceAround) return JustifyContent.spaceAround;
    if (spaceEvenly) return JustifyContent.spaceEvenly;

    return switch (alignment) {
      WrapAlignment.start => JustifyContent.start,
      WrapAlignment.end => JustifyContent.end,
      WrapAlignment.center => JustifyContent.center,
      WrapAlignment.spaceBetween => JustifyContent.spaceBetween,
      WrapAlignment.spaceAround => JustifyContent.spaceAround,
      WrapAlignment.spaceEvenly => JustifyContent.spaceEvenly,
    };
  }

  @override
  AlignItems? getAlignItems() {
    if (centered) return AlignItems.center;

    return switch (crossAlignment) {
      WrapCrossAlignment.start => AlignItems.start,
      WrapCrossAlignment.end => AlignItems.end,
      WrapCrossAlignment.center => AlignItems.center,
      WrapCrossAlignment.stretch => AlignItems.stretch,
      WrapCrossAlignment.baseline => AlignItems.baseline,
    };
  }

  @override
  Map<String, String> getAdditionalRawStyles() {
    final alignContent = switch (runAlignment) {
      WrapRunAlignment.start => 'flex-start',
      WrapRunAlignment.end => 'flex-end',
      WrapRunAlignment.center => 'center',
      WrapRunAlignment.spaceBetween => 'space-between',
      WrapRunAlignment.spaceAround => 'space-around',
      WrapRunAlignment.stretch => 'stretch',
    };
    return {'align-content': alignContent};
  }

  @override
  Styles applyLayoutStyles(Styles baseStyles) {
    final layoutStyles = Styles(
      display: getDisplay(),
      flexDirection: getFlexDirection(),
      flexWrap: getFlexWrap(),
      justifyContent: getJustifyContent(),
      alignItems: getAlignItems(),
      gap: spacing != null || runSpacing != null
          ? Gap(column: spacing, row: runSpacing)
          : null,
      raw: getAdditionalRawStyles(),
    );
    return layoutStyles.combine(baseStyles);
  }

  @override
  String applyLayoutClasses(String baseClasses) => baseClasses;
}

/// Default layout configuration for basic containers
class DefaultLayoutConfig extends LayoutConfig {
  const DefaultLayoutConfig();

  @override
  Display? getDisplay() => null;

  @override
  FlexDirection? getFlexDirection() => null;

  @override
  FlexWrap? getFlexWrap() => null;

  @override
  JustifyContent? getJustifyContent() => null;

  @override
  AlignItems? getAlignItems() => null;

  @override
  Map<String, String> getAdditionalRawStyles() => {};

  @override
  Styles applyLayoutStyles(Styles baseStyles) => baseStyles;

  @override
  String applyLayoutClasses(String baseClasses) => baseClasses;
}