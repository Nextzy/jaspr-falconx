import 'package:jaspr_falkit/lib.dart';

class MainContainer extends Container {
  const MainContainer(
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
    // Flexbox
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
  }) : super(layout: LayoutStyle.main);
}

class BodyContainer extends Container {
  const BodyContainer(
    super.children, {
    super.key,
    super.id,
    super.tailwind,
    String? classes,
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
    // Flexbox
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
  }) : super(
          layout: LayoutStyle.div,
          classes: 'flex flex-col justify-start items-center w-full h-screen '
              '${classes ?? ''}',
        );
}

class Section extends Container {
  const Section(
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
    // Flexbox
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
  }) : super(layout: LayoutStyle.section);
}

class Container extends StatelessComponent {
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
  });

  final String? id;
  final List<Component> children;
  final LayoutStyle layout;

  final String? content;
  final Display? display;
  final Position? position;
  final ZIndex? zIndex;
  final Unit? width;
  final Unit? height;
  final Unit? minWidth;
  final Unit? minHeight;
  final Unit? maxWidth;
  final Unit? maxHeight;
  final Padding? padding;
  final Margin? margin;
  final BoxSizing? boxSizing;
  final Border? border;
  final BorderRadius? radius;
  final Outline? outline;
  final double? opacity;
  final Visibility? visibility;
  final Overflow? overflow;
  final BoxShadow? shadow;
  final Cursor? cursor;
  final UserSelect? userSelect;
  final PointerEvents? pointerEvents;
  final Transition? transition;
  final Transform? transform;

  // Flexbox Styles
  final FlexDirection? flexDirection;
  final FlexWrap? flexWrap;
  final JustifyContent? justifyContent;
  final AlignItems? alignItems;

  // Grid Styles
  final GridTemplate? gridTemplate;
  final List<TrackSize>? autoRows;
  final List<TrackSize>? autoColumns;
  final Gap? gap;

  // Item Styles
  final Flex? flex;
  final int? order;
  final AlignSelf? alignSelf;
  final GridPlacement? gridPlacement;

  // List Styles
  final ListStyle? listStyle;
  final ImageStyle? listImage;
  final ListStylePosition? listPosition;

  // Text Styles
  final Color? color;
  final TextAlign? textAlign;
  final FontFamily? fontFamily;
  final Unit? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final TextTransform? textTransform;
  final Unit? textIndent;
  final Unit? letterSpacing;
  final Unit? wordSpacing;
  final Unit? lineHeight;
  final TextShadow? textShadow;
  final TextOverflow? textOverflow;
  final WhiteSpace? whiteSpace;

  // Background Styles
  final Color? backgroundColor;
  final ImageStyle? backgroundImage;
  final BackgroundOrigin? backgroundOrigin;
  final BackgroundPosition? backgroundPosition;
  final BackgroundAttachment? backgroundAttachment;
  final BackgroundRepeat? backgroundRepeat;
  final BackgroundSize? backgroundSize;
  final BackgroundClip? backgroundClip;

  // Raw Styles
  final Map<String, String>? rawStyle;

  final Styles? styles;

  final String? classes;
  final TailwindClass Function(TailwindClass tailwind)? tailwind;
  final Map<String, String>? attributes;

  @override
  Iterable<Component> build(BuildContext context) => [
        buildLayout(
          classes:
              '${classes ?? ''} ${tailwind?.call(TailwindClass()).build() ?? ''}'
                  .trim(),
          children,
        ),
      ];

  Component buildLayout(
    List<Component> children, {
    String? classes,
  }) {
    // Build comprehensive styles from all individual properties
    final baseStyles = Styles(
      // Dimensions
      width: width,
      height: height,
      minWidth: minWidth,
      minHeight: minHeight,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      // Layout
      content: content,
      display: display,
      position: position,
      zIndex: zIndex,
      // Spacing
      padding: padding,
      margin: margin,
      // Box Model
      boxSizing: boxSizing,
      border: border,
      radius: radius,
      outline: outline,
      // Visual
      opacity: opacity,
      visibility: visibility,
      overflow: overflow,
      shadow: shadow,
      // Interaction
      cursor: cursor,
      userSelect: userSelect,
      pointerEvents: pointerEvents,
      // Animation
      transition: transition,
      transform: transform,
      // Flexbox
      flexDirection: flexDirection,
      flexWrap: flexWrap,
      justifyContent: justifyContent,
      alignItems: alignItems,
      // Grid
      gridTemplate: gridTemplate,
      autoRows: autoRows,
      autoColumns: autoColumns,
      gap: gap,
      // Item
      flex: flex,
      order: order,
      alignSelf: alignSelf,
      gridPlacement: gridPlacement,
      // List
      listStyle: listStyle,
      listImage: listImage,
      listPosition: listPosition,
      // Text
      color: color,
      textAlign: textAlign,
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      textDecoration: textDecoration,
      textTransform: textTransform,
      textIndent: textIndent,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      lineHeight: lineHeight,
      textShadow: textShadow,
      textOverflow: textOverflow,
      whiteSpace: whiteSpace,
      // Background
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      backgroundOrigin: backgroundOrigin,
      backgroundPosition: backgroundPosition,
      backgroundAttachment: backgroundAttachment,
      backgroundRepeat: backgroundRepeat,
      backgroundSize: backgroundSize,
      backgroundClip: backgroundClip,
      raw: rawStyle,
    );

    // Combine with provided styles if any
    final combinedStyles = styles != null 
        ? baseStyles.combine(styles!) 
        : baseStyles;

    return switch (layout) {
      LayoutStyle.div => div(
          id: id,
          classes: classes,
          styles: combinedStyles,
          attributes: attributes ?? {},
          children,
        ),
      LayoutStyle.main => main_(
          id: id,
          classes: classes,
          styles: combinedStyles,
          attributes: attributes ?? {},
          children,
        ),
      LayoutStyle.section => section(
          id: id,
          classes: classes,
          styles: combinedStyles,
          attributes: attributes ?? {},
          children,
        ),
    };
  }
}
