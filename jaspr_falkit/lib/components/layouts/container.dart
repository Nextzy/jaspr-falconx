import 'package:jaspr_falkit/lib.dart';

/// Base container component with comprehensive styling and layout capabilities.
/// 
/// This is the foundation for all container components in the design system.
/// Specialized containers like RowContainer, ColumnContainer, etc. extend this class.
class Container extends StatelessComponent with ContainerBase {
  const Container(
    this.children, {
    super.key,
    this.layout = LayoutStyle.div,
    this.id,
    this.tailwind,
    this.classes,
    this.content,
    this.display,
    this.position,
    this.zIndex,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.padding,
    this.margin,
    this.boxSizing,
    this.border,
    this.radius,
    this.outline,
    this.opacity,
    this.visibility,
    this.overflow,
    this.shadow,
    this.cursor,
    this.userSelect,
    this.pointerEvents,
    this.transition,
    this.transform,
    // Flexbox Styles
    this.flexDirection,
    this.flexWrap,
    this.justifyContent,
    this.alignItems,
    // Grid Styles
    this.gridTemplate,
    this.autoRows,
    this.autoColumns,
    this.gap,
    // Item Styles
    this.flex,
    this.order,
    this.alignSelf,
    this.gridPlacement,
    // List Styles
    this.listStyle,
    this.listImage,
    this.listPosition,
    // Text Styles
    this.color,
    this.textAlign,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textDecoration,
    this.textTransform,
    this.textIndent,
    this.letterSpacing,
    this.wordSpacing,
    this.lineHeight,
    this.textShadow,
    this.textOverflow,
    this.whiteSpace,
    // Background Styles
    this.backgroundColor,
    this.backgroundImage,
    this.backgroundOrigin,
    this.backgroundPosition,
    this.backgroundAttachment,
    this.backgroundRepeat,
    this.backgroundSize,
    this.backgroundClip,
    // Raw Styles
    this.rawStyle,
    this.styles,
    this.attributes,
    // Layout configuration
    LayoutConfig? layoutConfig,
  }) : _layoutConfig = layoutConfig;

  @override
  final String? id;
  @override
  final List<Component> children;
  @override
  final LayoutStyle layout;

  @override
  final String? content;
  @override
  final Display? display;
  @override
  final Position? position;
  @override
  final ZIndex? zIndex;
  @override
  final Unit? width;
  @override
  final Unit? height;
  @override
  final Unit? minWidth;
  @override
  final Unit? minHeight;
  @override
  final Unit? maxWidth;
  @override
  final Unit? maxHeight;
  @override
  final Padding? padding;
  @override
  final Margin? margin;
  @override
  final BoxSizing? boxSizing;
  @override
  final Border? border;
  @override
  final BorderRadius? radius;
  @override
  final Outline? outline;
  @override
  final double? opacity;
  @override
  final Visibility? visibility;
  @override
  final Overflow? overflow;
  @override
  final BoxShadow? shadow;
  @override
  final Cursor? cursor;
  @override
  final UserSelect? userSelect;
  @override
  final PointerEvents? pointerEvents;
  @override
  final Transition? transition;
  @override
  final Transform? transform;

  // Flexbox Styles
  @override
  final FlexDirection? flexDirection;
  @override
  final FlexWrap? flexWrap;
  @override
  final JustifyContent? justifyContent;
  @override
  final AlignItems? alignItems;

  // Grid Styles
  @override
  final GridTemplate? gridTemplate;
  @override
  final List<TrackSize>? autoRows;
  @override
  final List<TrackSize>? autoColumns;
  @override
  final Gap? gap;

  // Item Styles
  @override
  final Flex? flex;
  @override
  final int? order;
  @override
  final AlignSelf? alignSelf;
  @override
  final GridPlacement? gridPlacement;

  // List Styles
  @override
  final ListStyle? listStyle;
  @override
  final ImageStyle? listImage;
  @override
  final ListStylePosition? listPosition;

  // Text Styles
  @override
  final Color? color;
  @override
  final TextAlign? textAlign;
  @override
  final FontFamily? fontFamily;
  @override
  final Unit? fontSize;
  @override
  final FontWeight? fontWeight;
  @override
  final FontStyle? fontStyle;
  @override
  final TextDecoration? textDecoration;
  @override
  final TextTransform? textTransform;
  @override
  final Unit? textIndent;
  @override
  final Unit? letterSpacing;
  @override
  final Unit? wordSpacing;
  @override
  final Unit? lineHeight;
  @override
  final TextShadow? textShadow;
  @override
  final TextOverflow? textOverflow;
  @override
  final WhiteSpace? whiteSpace;

  // Background Styles
  @override
  final Color? backgroundColor;
  @override
  final ImageStyle? backgroundImage;
  @override
  final BackgroundOrigin? backgroundOrigin;
  @override
  final BackgroundPosition? backgroundPosition;
  @override
  final BackgroundAttachment? backgroundAttachment;
  @override
  final BackgroundRepeat? backgroundRepeat;
  @override
  final BackgroundSize? backgroundSize;
  @override
  final BackgroundClip? backgroundClip;

  // Raw Styles
  @override
  final Map<String, String>? rawStyle;

  @override
  final Styles? styles;

  @override
  final String? classes;
  @override
  final TailwindClass Function(TailwindClass tailwind)? tailwind;
  @override
  final Map<String, String>? attributes;

  // Layout configuration
  final LayoutConfig? _layoutConfig;

  /// Get the layout configuration for this container
  @protected
  LayoutConfig get layoutConfig => _layoutConfig ?? const DefaultLayoutConfig();

  @override
  Iterable<Component> build(BuildContext context) => [
        buildLayout(
          classes: buildClasses(),
          children,
        ),
      ];

  /// Build the layout component
  @protected
  Component buildLayout(
    List<Component> children, {
    String? classes,
  }) {
    // Build base styles
    final baseStyles = buildStyles(
      additionalRawStyles: layoutConfig.getAdditionalRawStyles(),
    );
    
    // Apply layout-specific styles
    final finalStyles = layoutConfig.applyLayoutStyles(baseStyles);
    
    // Apply layout-specific classes
    final finalClasses = layoutConfig.applyLayoutClasses(classes ?? '');

    return buildLayoutComponent(
      id: id,
      classes: finalClasses,
      styles: finalStyles,
      attributes: attributes ?? {},
      children: children,
    );
  }
}

/// Specialized container implementations

/// Main container - renders as <main> element
class MainContainer extends Container {
  const MainContainer(
    super.children, {
    super.key,
    super.id,
    super.tailwind,
    super.classes,
    super.styles,
    super.attributes,
    // All other properties inherited from Container
    super.width,
    super.height,
    super.minWidth,
    super.minHeight,
    super.maxWidth,
    super.maxHeight,
    super.content,
    super.display,
    super.position,
    super.zIndex,
    super.padding,
    super.margin,
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
    super.rawStyle,
  }) : super(layout: LayoutStyle.main);
}

/// Body container with default flexbox layout
class BodyContainer extends Container {
  const BodyContainer(
    super.children, {
    super.key,
    super.id,
    super.tailwind,
    String? classes,
    super.styles,
    super.attributes,
    // All other properties inherited from Container
    super.width,
    super.height,
    super.minWidth,
    super.minHeight,
    super.maxWidth,
    super.maxHeight,
    super.content,
    super.display,
    super.position,
    super.zIndex,
    super.padding,
    super.margin,
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
    super.rawStyle,
  }) : super(
          layout: LayoutStyle.div,
          classes: 'flex flex-col justify-start items-center w-full h-screen '
              '${classes ?? ''}',
        );
}

/// Section container - renders as <section> element
class Section extends Container {
  const Section(
    super.children, {
    super.key,
    super.id,
    super.tailwind,
    super.classes,
    super.styles,
    super.attributes,
    // All other properties inherited from Container
    super.width,
    super.height,
    super.minWidth,
    super.minHeight,
    super.maxWidth,
    super.maxHeight,
    super.content,
    super.display,
    super.position,
    super.zIndex,
    super.padding,
    super.margin,
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
    super.rawStyle,
  }) : super(layout: LayoutStyle.section);
}