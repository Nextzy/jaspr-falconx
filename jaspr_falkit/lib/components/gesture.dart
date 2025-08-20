import 'package:jaspr_falkit/lib.dart';

typedef FocusCallback = void Function(bool focus);

class Gesture extends StatefulComponent {
  const Gesture({
    super.key,
    this.id,
    this.size = ComponentSize.medium,
    this.state = FullComponentState.normal,
    this.styles,
    this.focused = false,
    this.tailwind,
    this.classes,
    this.disabled = false,
    this.to,
    this.title,
    this.target,
    this.referrer,
    this.onClick,
    this.onHover,
    this.onPointerDown,
    this.onMouseOut,
    this.onFocus,
    this.attributes,
    this.children,
    this.child,
  });

  final String? id;
  final ComponentSize size;
  final FullComponentState state;
  final Styles? styles;
  final bool focused;
  final String? classes;
  final TailwindClass Function(TailwindClass tailwind)? tailwind;
  final bool disabled;
  final String? to;
  final String? title;
  final Target? target;
  final ReferrerPolicy? referrer;
  final List<Component>? children;
  final Component? child;
  final Map<String, String>? attributes;
  final VoidCallback? onClick;
  final VoidCallback? onPointerDown;
  final VoidCallback? onHover;
  final FocusCallback? onFocus;
  final VoidCallback? onMouseOut;

  @override
  State<Gesture> createState() => InteractionState();
}

class InteractionState extends State<Gesture> {
  ComponentSize get size => component.size; //
  bool get disabled => component.disabled; //
  String? get id => component.id; //
  String? get classes => component.classes; //
  Styles? get styles => component.styles; //
  TailwindClass Function(TailwindClass tailwind)? get tailwind =>
      component.tailwind; //
  String? get to => component.to; //
  String? get title => component.title; //
  Target? get target => component.target; //
  ReferrerPolicy? get referrer => component.referrer; //
  List<Component>? get children => component.children; //
  Component? get child => component.child; //
  Map<String, String>? get attributes => component.attributes; //

  VoidCallback? get onHover => component.onHover; //
  VoidCallback? get onClick => component.onClick; //
  VoidCallback? get onPointerDown => component.onPointerDown; //
  FocusCallback? get onFocus => component.onFocus; //
  VoidCallback? get onMouseOut => component.onMouseOut; //

  FullComponentState _state = FullComponentState.normal; //
  bool _focused = false; //

  @override
  void initState() {
    _state = component.state;
    _focused = component.focused;
    super.initState();
  }

  @override
  Iterable<Component> build(BuildContext context) => [
    buildInteraction(
      id: id,
      classes: classes,
      styles: styles,
      to: to,
      title: title,
      attributes: attributes,
      target: target,
      referrer: referrer,
      disabled: disabled,
      onClick: onClick,
      children: children,
      child: child,
    ),
  ];

  Component buildInteraction({
    String? id,
    String? classes,
    String? to,
    Styles? styles,
    String? title,
    Target? target,
    ReferrerPolicy? referrer,
    Map<String, String>? attributes,
    bool disabled = false,
    void Function()? onClick,
    List<Component>? children,
    Component? child,
  }) {
    final isExternal =
        to != null && (to.startsWith('http://') || to.startsWith('https://'));

    if (isExternal) {
      return a(
        id: id,
        href: to,
        styles: styles,
        attributes: {
          'role': 'button',
          if (title.isNotNullOrBlank) 'title': title!,
        }..addAll(attributes ?? {}),
        classes: TailwindClass()
            .classes(classes ?? '')
            .classes(tailwind?.call(TailwindClass()).build() ?? '')
            .condition(
              disabled,
              positive: (tailwind) => tailwind.cursorNotAllowed,
            )
            .build(),
        target: target,
        events: buildEventCallback(),
        children ??
            [
              if (child != null) child,
            ],
      );
    } else if (to.isNotNullOrEmpty) {
      return a(
        id: id,
        href: to!,
        target: target,
        styles: styles,
        referrerPolicy: referrer,
        classes: TailwindClass()
            .classes(classes ?? '')
            .classes(tailwind?.call(TailwindClass()).build() ?? '')
            .condition(
              disabled,
              positive: (tailwind) => tailwind.cursorNotAllowed,
            )
            .build(),
        attributes: {
          'role': 'button',
          if (title.isNotNullOrBlank) 'title': title!,
        }..addAll(attributes ?? {}),
        events: {
          'mouseover': (event) {
            final router = Router.maybeOf(context);
            if (router != null) {
              router.preload(to);
            }
            onHover?.call();
          },
          'click': (event) {
            final router = Router.maybeOf(context);
            if (router != null) {
              event.preventDefault();
              router.push(to);
            }
            onClick?.call();
          },
          'focusin': (event) {
            onFocus?.call(true);
          },
          'focusout': (event) {
            onFocus?.call(false);
          },
        },
        children ??
            [
              if (child != null) child,
            ],
      );
    } else {
      return button(
        id: id,
        type: ButtonType.button,
        disabled: disabled,
        attributes: attributes,
        styles: styles,
        events: buildEventCallback(),
        classes: TailwindClass()
            .classes(classes ?? '')
            .classes(tailwind?.call(TailwindClass()).build() ?? '')
            .condition(
              disabled,
              positive: (tailwind) => tailwind.cursorNotAllowed,
              negative: (tailwind) => tailwind.cursorPointer,
            )
            .build(),
        children ??
            [
              if (child != null) child,
            ],
      );
    }
  }

  Map<String, EventCallback> buildEventCallback() {
    return {
      if (onMouseOut != null)
        'mouseout': (event) {
          onMouseOut?.call();
        },
      if (onPointerDown != null)
        'pointerdown': (event) {
          onPointerDown?.call();
        },
      if (onHover != null)
        'mouseover': (event) {
          onHover?.call();
        },
      if (onClick != null)
        'click': (event) {
          onClick?.call();
        },
      if (onFocus != null)
        'focusin': (event) {
          onFocus?.call(true);
        },
      if (onFocus != null)
        'focusout': (event) {
          onFocus?.call(false);
        },
    };
  }
}
