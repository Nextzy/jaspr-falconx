import 'package:jaspr_falkit/lib.dart';

/// Base mixin for all container implementations providing common functionality
mixin ContainerBase on StatelessComponent {
  // Required properties that must be implemented
  String? get id;
  List<Component> get children;
  String? get classes;
  TailwindClass Function(TailwindClass tailwind)? get tailwind;
  Styles? get styles;
  Map<String, String>? get attributes;
  
  // Layout properties
  LayoutStyle get layout;
  Unit? get width;
  Unit? get height;
  Unit? get minWidth;
  Unit? get minHeight;
  Unit? get maxWidth;
  Unit? get maxHeight;
  
  // Spacing
  Padding? get padding;
  Margin? get margin;
  
  // Box Model
  BoxSizing? get boxSizing;
  Border? get border;
  BorderRadius? get radius;
  Outline? get outline;
  
  // Visual
  double? get opacity;
  Visibility? get visibility;
  Overflow? get overflow;
  BoxShadow? get shadow;
  
  // Display & Layout
  String? get content;
  Display? get display;
  Position? get position;
  ZIndex? get zIndex;
  
  // Interaction
  Cursor? get cursor;
  UserSelect? get userSelect;
  PointerEvents? get pointerEvents;
  
  // Animation
  Transition? get transition;
  Transform? get transform;
  
  // Flexbox
  FlexDirection? get flexDirection;
  FlexWrap? get flexWrap;
  JustifyContent? get justifyContent;
  AlignItems? get alignItems;
  
  // Grid
  GridTemplate? get gridTemplate;
  List<TrackSize>? get autoRows;
  List<TrackSize>? get autoColumns;
  Gap? get gap;
  
  // Item
  Flex? get flex;
  int? get order;
  AlignSelf? get alignSelf;
  GridPlacement? get gridPlacement;
  
  // List
  ListStyle? get listStyle;
  ImageStyle? get listImage;
  ListStylePosition? get listPosition;
  
  // Text
  Color? get color;
  TextAlign? get textAlign;
  FontFamily? get fontFamily;
  Unit? get fontSize;
  FontWeight? get fontWeight;
  FontStyle? get fontStyle;
  TextDecoration? get textDecoration;
  TextTransform? get textTransform;
  Unit? get textIndent;
  Unit? get letterSpacing;
  Unit? get wordSpacing;
  Unit? get lineHeight;
  TextShadow? get textShadow;
  TextOverflow? get textOverflow;
  WhiteSpace? get whiteSpace;
  
  // Background
  Color? get backgroundColor;
  ImageStyle? get backgroundImage;
  BackgroundOrigin? get backgroundOrigin;
  BackgroundPosition? get backgroundPosition;
  BackgroundAttachment? get backgroundAttachment;
  BackgroundRepeat? get backgroundRepeat;
  BackgroundSize? get backgroundSize;
  BackgroundClip? get backgroundClip;
  
  // Raw styles
  Map<String, String>? get rawStyle;

  /// Build the final classes string from classes and tailwind
  String buildClasses() {
    return '${classes ?? ''} ${tailwind?.call(TailwindClass()).build() ?? ''}'
        .trim();
  }

  /// Build the styles object from all properties
  Styles buildStyles({Map<String, String>? additionalRawStyles}) {
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
      raw: {
        ...?rawStyle,
        ...?additionalRawStyles,
      },
    );

    // Combine with provided styles if any
    return styles != null ? baseStyles.combine(styles!) : baseStyles;
  }

  /// Build the layout component based on layout style
  Component buildLayoutComponent({
    required String? id,
    required String classes,
    required Styles styles,
    required Map<String, String> attributes,
    required List<Component> children,
  }) {
    return switch (layout) {
      LayoutStyle.div => div(
          id: id,
          classes: classes,
          styles: styles,
          attributes: attributes,
          children,
        ),
      LayoutStyle.main => main_(
          id: id,
          classes: classes,
          styles: styles,
          attributes: attributes,
          children,
        ),
      LayoutStyle.section => section(
          id: id,
          classes: classes,
          styles: styles,
          attributes: attributes,
          children,
        ),
    };
  }
}