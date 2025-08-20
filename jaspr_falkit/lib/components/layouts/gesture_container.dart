import 'package:jaspr_falkit/lib.dart';
import 'base/base.dart';

/// A container that adds interaction capabilities to the base Container.
///
/// Extends Container to provide full layout and styling capabilities
/// while adding interaction features like clicks, hovers, and navigation.
class GestureContainer extends Container {
  const GestureContainer(
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
    // Layout configuration (can be passed through)
    super.layoutConfig,
    // Gesture specific
    this.focused = false,
    this.disabled = false,
    this.to,
    this.target,
    this.referrer,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onHover,
    this.onEnter,
    this.onExit,
    this.onFocus,
    this.onBlur,
    this.onContextMenu,
    this.title,
  }) : super(
         layout: LayoutStyle.div,
       );

  /// Whether the interaction is focused
  final bool focused;

  /// Whether the interaction is disabled
  final bool disabled;

  /// Navigation URL
  final String? to;

  /// Navigation target
  final Target? target;

  /// Referrer policy for navigation
  final ReferrerPolicy? referrer;

  /// Tap/click event handler
  final VoidCallback? onTap;

  /// Double tap event handler
  final VoidCallback? onDoubleTap;

  /// Long press event handler
  final VoidCallback? onLongPress;

  /// Tap down event handler
  final VoidCallback? onTapDown;

  /// Tap up event handler
  final VoidCallback? onTapUp;

  /// Tap cancel event handler
  final VoidCallback? onTapCancel;

  /// Hover event handler
  final ValueChanged<bool>? onHover;

  /// Mouse/pointer enter event handler
  final VoidCallback? onEnter;

  /// Mouse/pointer exit event handler
  final VoidCallback? onExit;

  /// Focus event handler
  final VoidCallback? onFocus;

  /// Blur event handler
  final VoidCallback? onBlur;

  /// Context menu event handler
  final VoidCallback? onContextMenu;

  /// Title/tooltip text
  final String? title;

  @override
  Iterable<Component> build(BuildContext context) => [
    Gesture(
      disabled: disabled,
      focused: focused,
      to: to,
      target: target,
      referrer: referrer,
      onClick: onTap,
      onHover: onHover != null ? () => onHover!(true) : null,
      onPointerDown: onTapDown,
      onMouseOut: onExit,
      onFocus: onFocus != null ? (e) => onFocus!() : null,
      title: title,
      child: buildLayout(
        classes: buildClasses(),
        children,
      ),
    ),
  ];
}

/// Convenience factory for creating gesture containers with common patterns
class Interact {
  /// Create a simple tappable container
  static GestureContainer tappable(
    List<Component> children, {
    required VoidCallback onTap,
    Key? key,
  }) => GestureContainer(
    children,
    key: key,
    onTap: onTap,
    cursor: Cursor.pointer,
  );

  /// Create a hoverable container
  static GestureContainer hoverable(
    List<Component> children, {
    required ValueChanged<bool> onHover,
    Key? key,
  }) => GestureContainer(
    children,
    key: key,
    onHover: onHover,
    cursor: Cursor.pointer,
  );

  /// Create a link container
  static GestureContainer link(
    List<Component> children, {
    required String to,
    Target? target,
    Key? key,
  }) => GestureContainer(
    children,
    key: key,
    to: to,
    target: target,
    cursor: Cursor.pointer,
  );

  /// Create a button-like container
  static GestureContainer button(
    List<Component> children, {
    required VoidCallback onTap,
    bool disabled = false,
    Key? key,
  }) => GestureContainer(
    children,
    key: key,
    onTap: onTap,
    disabled: disabled,
    cursor: disabled ? Cursor.notAllowed : Cursor.pointer,
  );
}
