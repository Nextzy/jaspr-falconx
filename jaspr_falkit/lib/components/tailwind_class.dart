extension TailwindClassExtensionString on String {
  TailwindClass toTailwindClass() {
    return TailwindClass(this);
  }
}

class TailwindClass {
  TailwindClass([
    this.initialClass,
  ]);

  final String? initialClass;
  final List<String> _classList = [];

  TailwindClass tailwindBuilder(
          TailwindClass Function(TailwindClass tailwind)? builder) =>
      builder != null ? tailwind(builder.call(TailwindClass())) : this;

  TailwindClass tailwind(TailwindClass? tailwind) =>
      tailwind != null ? (this.._classList.add(tailwind.build())) : this;

  TailwindClass classes(String? classes) =>
      classes != null ? (this.._classList.add(classes)) : this;

  TailwindClass state({
    String? hoverClasses,
    TailwindClass Function(TailwindClass tailwind)? hover,
    String? activeClasses,
    TailwindClass Function(TailwindClass tailwind)? active,
    String? focusClasses,
    TailwindClass Function(TailwindClass tailwind)? focus,
    String? disabledClasses,
    TailwindClass Function(TailwindClass tailwind)? disabled,
  }) =>
      // Hover
      classes(hoverClasses)
          .tailwindBuilder(hover)
          // Active
          .classes(activeClasses)
          .tailwindBuilder(active)
          // Focus
          .classes(focusClasses)
          .tailwindBuilder(focus)
          // Disabled
          .classes(disabledClasses)
          .tailwindBuilder(disabled);

  TailwindClass belowMobileLandscape({
    String? classes,
    TailwindClass Function(TailwindClass tailwind)? tailwind,
  }) =>
      this.classes(classes).tailwindBuilder(tailwind);

  TailwindClass aboveMobileLandscape({
    String? classes,
    TailwindClass Function(TailwindClass tailwind)? tailwind,
  }) =>
      this.classes(classes).tailwindBuilder(tailwind);

  TailwindClass belowTablet({
    String? classes,
    TailwindClass Function(TailwindClass tailwind)? tailwind,
  }) =>
      this.classes(classes).tailwindBuilder(tailwind);

  TailwindClass aboveTablet({
    String? classes,
    TailwindClass Function(TailwindClass tailwind)? tailwind,
  }) =>
      this.classes(classes).tailwindBuilder(tailwind);

  TailwindClass belowDesktop({
    String? classes,
    TailwindClass Function(TailwindClass tailwind)? tailwind,
  }) =>
      this.classes(classes).tailwindBuilder(tailwind);

  TailwindClass aboveDesktop({
    String? classes,
    TailwindClass Function(TailwindClass tailwind)? tailwind,
  }) =>
      this.classes(classes).tailwindBuilder(tailwind);

  TailwindClass condition(
    bool condition, {
    String? positiveClasses,
    String? negativeClasses,
    TailwindClass Function(TailwindClass tailwind)? positive,
    TailwindClass Function(TailwindClass tailwind)? negative,
  }) =>
      condition
          ? classes(positiveClasses).tailwindBuilder(positive)
          : classes(negativeClasses).tailwindBuilder(negative);

  ///========================= THEMES =========================///

  TailwindClass get hiddenAboveMobileLandscape =>
      this.._classList.add('mobile-land:hidden'); //
  TailwindClass get hiddenAboveTablet =>
      this.._classList.add('tablet:hidden'); //
  TailwindClass get hiddenAboveDesktop =>
      this.._classList.add('desktop:hidden'); //
  TailwindClass get hiddenBelowMobileLandscape =>
      this.._classList.add('max-mobile-land:hidden'); //
  TailwindClass get hiddenBelowTablet =>
      this.._classList.add('max-tablet:hidden'); //
  TailwindClass get hiddenBelowDesktop =>
      this.._classList.add('max-desktop:hidden'); //

  TailwindClass get visibleAboveMobileLandscape =>
      this.._classList.add('mobile-land:visible'); //
  TailwindClass get visibleAboveTablet =>
      this.._classList.add('tablet:visible'); //
  TailwindClass get visibleAboveDesktop =>
      this.._classList.add('desktop:visible'); //
  TailwindClass get visibleBelowMobileLandscape =>
      this.._classList.add('max-mobile-land:visible'); //
  TailwindClass get visibleBelowTablet =>
      this.._classList.add('max-tablet:visible'); //
  TailwindClass get visibleBelowDesktop =>
      this.._classList.add('max-desktop:visible'); //

  TailwindClass get invisibleAboveMobileLandscape =>
      this.._classList.add('mobile-land:invisible'); //
  TailwindClass get invisibleAboveTablet =>
      this.._classList.add('tablet:invisible'); //
  TailwindClass get invisibleAboveDesktop =>
      this.._classList.add('desktop:invisible'); //
  TailwindClass get invisibleBelowMobileLandscape =>
      this.._classList.add('max-mobile-land:invisible'); //
  TailwindClass get invisibleBelowTablet =>
      this.._classList.add('max-tablet:invisible'); //
  TailwindClass get invisibleBelowDesktop =>
      this.._classList.add('max-desktop:invisible'); //

  TailwindClass get textHeader1 =>
      ((this.._classList.add('text-[2.25rem] font-bold leading-[3.325rem]')) //
        .._classList.add('tablet:text-[2.25rem] tablet:leading-[3.325rem]')) //
        .._classList.add('desktop:text-[3.5rem] desktop:leading-[4.75rem]'); //;

  TailwindClass get textHeader2 =>
      ((this.._classList.add('text-[1.5rem] font-bold leading-[2.5rem]')) //
        .._classList.add('tablet:text-[1.5rem] tablet:leading-[2.5rem]')) //
        .._classList
            .add('desktop:text-[2.25rem] desktop:leading-[3.325rem]'); //;

  TailwindClass get textHeader3 =>
      ((this.._classList.add('text-[1.25rem] font-bold leading-[2rem]')) //
        .._classList.add('tablet:text-[1.25rem] tablet:leading-[2rem]')) //
        .._classList.add('desktop:text-[1.5rem] desktop:leading-[2.5rem]'); //;

  TailwindClass get textHeader4 =>
      this.._classList.add('text-[1.25rem] font-bold leading-[2rem]'); //
  TailwindClass get textHeader5 =>
      this.._classList.add('text-[1.125rem] font-bold leading-[2rem]'); //
  TailwindClass get textHeader6 =>
      this.._classList.add('text-[0.875rem] font-bold leading-[2rem]'); //

  TailwindClass
      get textParagraphExtraLarge =>
          ((this
            .._classList
                .add('text-[1.25rem] leading-[2.25rem] font-paragraph')) //
            .._classList
                .add('tablet:text-[1.25rem] tablet:leading-[2.25rem]')) //
            .._classList
                .add('desktop:text-[1.375rem] desktop:leading-[2.5rem]'); //;

  TailwindClass
      get textParagraphLarge =>
          ((this
            .._classList
                .add('text-[1.125rem] leading-[2rem] font-paragraph')) //
            .._classList.add('tablet:text-[1.125rem] tablet:leading-[2rem]')) //
            .._classList
                .add('desktop:text-[1.25rem] desktop:leading-[2.25rem]'); //;
  TailwindClass get textParagraphMedium =>
      ((this.._classList.add('text-[1rem] leading-[1.75rem] font-paragraph')) //
        .._classList.add('tablet:text-[1rem] tablet:leading-[1.75rem]')) //
        .._classList.add('desktop:text-[1.125rem] desktop:leading-[2rem]'); //;
  TailwindClass
      get textParagraphSmall =>
          ((this.._classList.add('text-[0.875rem] leading-[1.5rem] font-paragraph'))
            .._classList
                .add('tablet:text-[0.875rem] tablet:leading-[1.5rem]')) //
            .._classList
                .add('desktop:text-[1rem] desktop:leading-[1.75rem]'); //;

  TailwindClass get textUiLarge =>
      ((this.._classList.add('text-[1rem] leading-[1.5rem]')) //
        .._classList.add('tablet:text-[1rem] tablet:leading-[1.5rem]')) //
        .._classList
            .add('desktop:text-[1.125rem] desktop:leading-[1.75rem]'); //;
  TailwindClass
      get textUiMedium =>
          ((this.._classList.add('text-[0.875rem] leading-[1.5rem]')) //
            .._classList
                .add('tablet:text-[0.875rem] tablet:leading-[1.5rem]')) //
            .._classList
                .add('desktop:text-[1rem] desktop:leading-[1.5rem]'); //;
  TailwindClass
      get textUiSmall =>
          ((this.._classList.add('text-[0.75rem] leading-[1.25rem]')) //
            .._classList
                .add('tablet:text-[0.75rem] tablet:leading-[1.25rem]')) //
            .._classList
                .add('desktop:text-[0.875rem] desktop:leading-[1.5rem]'); //;
  TailwindClass get textUiTiny =>
      ((this.._classList.add('text-[0.625rem] leading-[1rem]')) //
        .._classList.add('tablet:text-[0.625rem] tablet:leading-[1rem]')) //
        .._classList.add('desktop:text-[0.75rem] desktop:leading-[1rem]'); //;

  TailwindClass get regular => this.._classList.add('!font-normal'); //
  TailwindClass get medium => this.._classList.add('!font-medium'); //
  TailwindClass get semibold => this.._classList.add('!font-semibold'); //
  TailwindClass get bold => this.._classList.add('!font-bold'); //
  TailwindClass get italic => this.._classList.add('!italic'); //

  TailwindClass get textPrimaryColor =>
      this.._classList.add('text-text-primary'); //
  TailwindClass get textPrimaryColorImportant =>
      this.._classList.add('!text-text-primary'); //
  TailwindClass get textPrimaryOnColor =>
      this.._classList.add('text-text-primary-on-color'); //
  TailwindClass get textPrimaryOnColorImportant =>
      this.._classList.add('!text-text-primary-on-color'); //
  TailwindClass get textPrimaryInverseColor =>
      this.._classList.add('text-text-primary-inverse'); //
  TailwindClass get textPrimaryInverseColorImportant =>
      this.._classList.add('!text-text-primary-inverse'); //

  TailwindClass get textSecondaryColor =>
      this.._classList.add('text-text-secondary'); //
  TailwindClass get textSecondaryColorImportant =>
      this.._classList.add('!text-text-secondary'); //
  TailwindClass get textSecondaryOnColor =>
      this.._classList.add('text-text-secondary-on-color'); //
  TailwindClass get textSecondaryOnColorImportant =>
      this.._classList.add('!text-text-secondary-on-color'); //
  TailwindClass get textSecondaryInverseColor =>
      this.._classList.add('text-text-secondary-inverse'); //
  TailwindClass get textSecondaryInverseColorImportant =>
      this.._classList.add('!text-text-secondary-inverse'); //

  TailwindClass get textTertiaryColor =>
      this.._classList.add('text-text-tertiary'); //
  TailwindClass get textTertiaryColorImportant =>
      this.._classList.add('!text-text-tertiary'); //

  TailwindClass get textBrandColor =>
      this.._classList.add('text-text-brand'); //
  TailwindClass get textBrandColorImportant =>
      this.._classList.add('!text-text-brand'); //
  TailwindClass get textBlueColor => this.._classList.add('text-text-blue'); //
  TailwindClass get textNegativeColor =>
      this.._classList.add('text-text-negative'); //
  TailwindClass get textWarningColor =>
      this.._classList.add('text-text-warning'); //
  TailwindClass get textPositiveColor =>
      this.._classList.add('text-text-positive'); //
  TailwindClass get textVioletColor =>
      this.._classList.add('text-text-violet'); //
  TailwindClass get textTealColor => this.._classList.add('text-text-teal'); //

  TailwindClass get textTransparent1 =>
      this.._classList.add('text-transparent-1-inverse'); //
  TailwindClass get textTransparent2 =>
      this.._classList.add('text-transparent-2-inverse'); //
  TailwindClass get textTransparent3 =>
      this.._classList.add('text-transparent-3-inverse'); //
  TailwindClass get textTransparent4 =>
      this.._classList.add('text-transparent-4-inverse'); //
  TailwindClass get textTransparent5 =>
      this.._classList.add('text-transparent-5-inverse'); //
  TailwindClass get textTransparent6 =>
      this.._classList.add('text-transparent-6-inverse'); //
  TailwindClass get textTransparent7 =>
      this.._classList.add('text-transparent-7-inverse'); //
  TailwindClass get textTransparent8 =>
      this.._classList.add('text-transparent-8-inverse'); //
  TailwindClass get textTransparent10 =>
      this.._classList.add('text-transparent-10-inverse'); //
  TailwindClass get textTransparent15 =>
      this.._classList.add('text-transparent-15-inverse'); //
  TailwindClass get textTransparent20 =>
      this.._classList.add('text-transparent-20-inverse'); //
  TailwindClass get textTransparent25 =>
      this.._classList.add('text-transparent-25-inverse'); //
  TailwindClass get textTransparent30 =>
      this.._classList.add('text-transparent-30-inverse'); //
  TailwindClass get textTransparent35 =>
      this.._classList.add('text-transparent-35-inverse'); //
  TailwindClass get textTransparent40 =>
      this.._classList.add('text-transparent-40-inverse'); //
  TailwindClass get textTransparent45 =>
      this.._classList.add('text-transparent-45-inverse'); //
  TailwindClass get textTransparent50 =>
      this.._classList.add('text-transparent-50-inverse'); //
  TailwindClass get textTransparent60 =>
      this.._classList.add('text-transparent-60-inverse'); //
  TailwindClass get textTransparent70 =>
      this.._classList.add('text-transparent-70-inverse'); //
  TailwindClass get textTransparent80 =>
      this.._classList.add('text-transparent-80-inverse'); //
  TailwindClass get textTransparent90 =>
      this.._classList.add('text-transparent-90-inverse'); //
  TailwindClass get textTransparent95 =>
      this.._classList.add('text-transparent-95-inverse'); //
  TailwindClass get textTransparent100 =>
      this.._classList.add('text-transparent-100-inverse'); //

  TailwindClass get filterIconPrimary =>
      this.._classList.add('filter-(--filter-icon-primary)'); //
  TailwindClass get filterIconPrimaryOnColor =>
      this.._classList.add('filter-(--filter-icon-primary-on-color)'); //
  TailwindClass get filterIconSecondary =>
      this.._classList.add('filter-(--filter-icon-secondary)'); //
  TailwindClass get filterIconTertiary =>
      this.._classList.add('filter-(--filter-icon-tertiary)'); //
  TailwindClass get filterIconWarning =>
      this.._classList.add('filter-(--filter-icon-warning)'); //

  TailwindClass get fillIconPrimary =>
      this.._classList.add('fill-icon-primary'); //
  TailwindClass get fillIconPrimaryInverse =>
      this.._classList.add('fill-icon-primary-inverse'); //
  TailwindClass get fillIconPrimaryOnColor =>
      this.._classList.add('fill-icon-primary-on-color'); //
  TailwindClass get fillIconSecondary =>
      this.._classList.add('fill-icon-secondary'); //
  TailwindClass get fillIconTertiary =>
      this.._classList.add('fill-icon-tertiary'); //
  TailwindClass get fillIconBrand => this.._classList.add('fill-icon-brand'); //
  TailwindClass get fillIconPositive =>
      this.._classList.add('fill-icon-positive'); //
  TailwindClass get fillIconWarning =>
      this.._classList.add('fill-icon-warning'); //
  TailwindClass get fillIconNegative =>
      this.._classList.add('fill-icon-negative'); //
  TailwindClass get fillIconTeal => this.._classList.add('fill-icon-teal'); //
  TailwindClass get fillIconViolet =>
      this.._classList.add('fill-icon-violet'); //
  TailwindClass get fillIconBlue => this.._classList.add('fill-icon-blue'); //

  TailwindClass get borderDefaultColor =>
      this.._classList.add('border-border-default'); //
  TailwindClass get borderDefaultHoverColor =>
      this.._classList.add('border-border-default-hover'); //
  TailwindClass get borderDefaultActiveColor =>
      this.._classList.add('border-border-default-active'); //
  TailwindClass get borderDefaultOnColorColor =>
      this.._classList.add('border-border-default-on-color'); //
  TailwindClass get borderDefaultInverseColor =>
      this.._classList.add('border-border-default-inverse'); //
  TailwindClass get borderBrandColor =>
      this.._classList.add('border-border-brand'); //
  TailwindClass get borderBlueColor =>
      this.._classList.add('border-border-blue'); //
  TailwindClass get borderPositiveColor =>
      this.._classList.add('border-border-positive'); //
  TailwindClass get borderWarningColor =>
      this.._classList.add('border-border-waring'); //
  TailwindClass get borderNegativeColor =>
      this.._classList.add('border-border-negative'); //
  TailwindClass get borderVioletColor =>
      this.._classList.add('border-border-violet'); //
  TailwindClass get borderTealColor =>
      this.._classList.add('border-border-teal'); //
  TailwindClass get borderGrayColor =>
      this.._classList.add('border-border-Gray'); //
  TailwindClass get borderSubtleBrandColor =>
      this.._classList.add('border-border-subtle-brand'); //
  TailwindClass get borderSubtleBlueColor =>
      this.._classList.add('border-border-subtle-blue'); //
  TailwindClass get borderSubtlePositiveColor =>
      this.._classList.add('border-border-subtle-positive'); //
  TailwindClass get borderSubtleWarningColor =>
      this.._classList.add('border-border-subtle-waring'); //
  TailwindClass get borderSubtleNegativeColor =>
      this.._classList.add('border-border-subtle-negative'); //
  TailwindClass get borderSubtleVioletColor =>
      this.._classList.add('border-border-subtle-violet'); //
  TailwindClass get borderSubtleTealColor =>
      this.._classList.add('border-border-subtle-teal'); //
  TailwindClass get borderSubtleGrayColor =>
      this.._classList.add('border-border-subtle-gray'); //

  TailwindClass get outlineDefaultColor =>
      this.._classList.add('outline-border-default'); //
  TailwindClass get outlineDefaultHoverColor =>
      this.._classList.add('outline-border-default-hover'); //
  TailwindClass get outlineDefaultActiveColor =>
      this.._classList.add('outline-border-default-active'); //
  TailwindClass get outlineDefaultOnColorColor =>
      this.._classList.add('outline-border-default-on-color'); //
  TailwindClass get outlineDefaultInverseColor =>
      this.._classList.add('outline-border-default-inverse'); //
  TailwindClass get outlineBrandColor =>
      this.._classList.add('outline-border-brand'); //
  TailwindClass get outlineBlueColor =>
      this.._classList.add('outline-border-blue'); //
  TailwindClass get outlinePositiveColor =>
      this.._classList.add('outline-border-positive'); //
  TailwindClass get outlineWarningColor =>
      this.._classList.add('outline-border-waring'); //
  TailwindClass get outlineNegativeColor =>
      this.._classList.add('outline-border-negative'); //
  TailwindClass get outlineVioletColor =>
      this.._classList.add('outline-border-violet'); //
  TailwindClass get outlineTealColor =>
      this.._classList.add('outline-border-teal'); //
  TailwindClass get outlineGrayColor =>
      this.._classList.add('outline-border-Gray'); //
  TailwindClass get outlineSubtleBrandColor =>
      this.._classList.add('outline-border-subtle-brand'); //
  TailwindClass get outlineSubtleBlueColor =>
      this.._classList.add('outline-border-subtle-blue'); //
  TailwindClass get outlineSubtlePositiveColor =>
      this.._classList.add('outline-border-subtle-positive'); //
  TailwindClass get outlineSubtleWarningColor =>
      this.._classList.add('outline-border-subtle-waring'); //
  TailwindClass get outlineSubtleNegativeColor =>
      this.._classList.add('outline-border-subtle-negative'); //
  TailwindClass get outlineSubtleVioletColor =>
      this.._classList.add('outline-border-subtle-violet'); //
  TailwindClass get outlineSubtleTealColor =>
      this.._classList.add('outline-border-subtle-teal'); //
  TailwindClass get outlineSubtleGrayColor =>
      this.._classList.add('outline-border-subtle-gray'); //

  TailwindClass get ringDefaultColor =>
      this.._classList.add('ring-border-default'); //
  TailwindClass get ringDefaultHoverColor =>
      this.._classList.add('ring-border-default-hover'); //
  TailwindClass get ringDefaultActiveColor =>
      this.._classList.add('ring-border-default-active'); //
  TailwindClass get ringDefaultOnColorColor =>
      this.._classList.add('ring-border-default-on-color'); //
  TailwindClass get ringDefaultInverseColor =>
      this.._classList.add('ring-border-default-inverse'); //
  TailwindClass get ringBrandColor =>
      this.._classList.add('ring-border-brand'); //
  TailwindClass get ringBlueColor =>
      this.._classList.add('ring-border-blue'); //
  TailwindClass get ringPositiveColor =>
      this.._classList.add('ring-border-positive'); //
  TailwindClass get ringWarningColor =>
      this.._classList.add('ring-border-waring'); //
  TailwindClass get ringNegativeColor =>
      this.._classList.add('ring-border-negative'); //
  TailwindClass get ringVioletColor =>
      this.._classList.add('ring-border-violet'); //
  TailwindClass get ringTealColor =>
      this.._classList.add('ring-border-teal'); //
  TailwindClass get ringGrayColor =>
      this.._classList.add('ring-border-Gray'); //
  TailwindClass get ringSubtleBrandColor =>
      this.._classList.add('ring-border-subtle-brand'); //
  TailwindClass get ringSubtleBlueColor =>
      this.._classList.add('ring-border-subtle-blue'); //
  TailwindClass get ringSubtlePositiveColor =>
      this.._classList.add('ring-border-subtle-positive'); //
  TailwindClass get ringSubtleWarningColor =>
      this.._classList.add('ring-border-subtle-waring'); //
  TailwindClass get ringSubtleNegativeColor =>
      this.._classList.add('ring-border-subtle-negative'); //
  TailwindClass get ringSubtleVioletColor =>
      this.._classList.add('ring-border-subtle-violet'); //
  TailwindClass get ringSubtleTealColor =>
      this.._classList.add('ring-border-subtle-teal'); //
  TailwindClass get ringSubtleGrayColor =>
      this.._classList.add('ring-border-subtle-gray'); //

  TailwindClass get buttonPrimaryColor =>
      this.._classList.add('bg-button-primary'); //
  TailwindClass get buttonPrimaryHoverColor =>
      this.._classList.add('bg-button-primary-hover'); //
  TailwindClass get buttonPrimaryActiveColor =>
      this.._classList.add('bg-button-primary-active'); //
  TailwindClass get buttonSecondaryHoverColor =>
      this.._classList.add('bg-button-secondary-hover'); //
  TailwindClass get buttonSecondaryActiveColor =>
      this.._classList.add('bg-button-secondary-active'); //
  TailwindClass get buttonShadeColor =>
      this.._classList.add('bg-button-shaded'); //
  TailwindClass get buttonShadeHoverColor =>
      this.._classList.add('bg-button-shaded-hover'); //
  TailwindClass get buttonShadeActiveColor =>
      this.._classList.add('bg-button-shaded-active'); //
  TailwindClass get buttonDestructiveColor =>
      this.._classList.add('bg-button-destructive'); //
  TailwindClass get buttonDestructiveHoverColor =>
      this.._classList.add('bg-button-destructive-hover'); //
  TailwindClass get buttonDestructiveActiveColor =>
      this.._classList.add('bg-button-destructive-active'); //
  TailwindClass get buttonFilledColor =>
      this.._classList.add('bg-button-filled'); //
  TailwindClass get buttonFilledHoverColor =>
      this.._classList.add('bg-button-filled-hover'); //
  TailwindClass get buttonFilledActiveColor =>
      this.._classList.add('bg-button-filled-active'); //

  TailwindClass get backgroundDefault =>
      this.._classList.add('bg-bg-default'); //
  TailwindClass get backgroundDefaultInverse =>
      this.._classList.add('bg-bg-default-inverse'); //
  TailwindClass get backgroundTransparent =>
      this.._classList.add('bg-bg-transparent'); //
  TailwindClass get backgroundBrand => this.._classList.add('bg-bg-brand'); //
  TailwindClass get backgroundBlue => this.._classList.add('bg-bg-blue'); //
  TailwindClass get backgroundNegative =>
      this.._classList.add('bg-bg-negative'); //
  TailwindClass get backgroundWarning =>
      this.._classList.add('bg-bg-warning'); //
  TailwindClass get backgroundPositive =>
      this.._classList.add('bg-bg-positive'); //
  TailwindClass get backgroundViolet => this.._classList.add('bg-bg-violet'); //
  TailwindClass get backgroundTeal => this.._classList.add('bg-bg-teal'); //
  TailwindClass get backgroundGray => this.._classList.add('bg-bg-gray'); //
  TailwindClass get backgroundMutedBrand =>
      this.._classList.add('bg-bg-muted-brand'); //
  TailwindClass get backgroundMutedBlue =>
      this.._classList.add('bg-bg-muted-blue'); //
  TailwindClass get backgroundMutedNegative =>
      this.._classList.add('bg-bg-muted-negative'); //
  TailwindClass get backgroundMutedWarning =>
      this.._classList.add('bg-bg-muted-warning'); //
  TailwindClass get backgroundMutedPositive =>
      this.._classList.add('bg-bg-muted-positive'); //
  TailwindClass get backgroundMutedViolet =>
      this.._classList.add('bg-bg-muted-violet'); //
  TailwindClass get backgroundMutedTeal =>
      this.._classList.add('bg-bg-muted-teal'); //
  TailwindClass get backgroundMutedGray =>
      this.._classList.add('bg-bg-muted-gray'); //
  TailwindClass get backgroundSubtleBrand =>
      this.._classList.add('bg-bg-subtle-brand'); //
  TailwindClass get backgroundSubtleBlue =>
      this.._classList.add('bg-bg-subtle-blue'); //
  TailwindClass get backgroundSubtleNegative =>
      this.._classList.add('bg-bg-subtle-negative'); //
  TailwindClass get backgroundSubtleWarning =>
      this.._classList.add('bg-bg-subtle-warning'); //
  TailwindClass get backgroundSubtlePositive =>
      this.._classList.add('bg-bg-subtle-positive'); //
  TailwindClass get backgroundSubtleViolet =>
      this.._classList.add('bg-bg-subtle-violet'); //
  TailwindClass get backgroundSubtleTeal =>
      this.._classList.add('bg-bg-subtle-teal'); //
  TailwindClass get backgroundSubtleGray =>
      this.._classList.add('bg-bg-subtle-gray'); //
  TailwindClass get backgroundSurface1 =>
      this.._classList.add('bg-bg-surface-1'); //
  TailwindClass get backgroundSurface1Hover =>
      this.._classList.add('bg-bg-surface-1-hover'); //
  TailwindClass get backgroundSurface1Active =>
      this.._classList.add('bg-bg-surface-1-active'); //
  TailwindClass get surface2 => this.._classList.add('bg-bg-surface-2'); //
  TailwindClass get surface2Hover =>
      this.._classList.add('bg-bg-surface-2-hover'); //
  TailwindClass get surface2Active =>
      this.._classList.add('bg-bg-surface-2-active'); //
  TailwindClass get surface3 => this.._classList.add('bg-bg-surface-3'); //
  TailwindClass get surface3Hover =>
      this.._classList.add('bg-bg-surface-3-hover'); //
  TailwindClass get surface3Active =>
      this.._classList.add('bg-bg-surface-3-active'); //
  TailwindClass get surface4 => this.._classList.add('bg-bg-surface-4'); //
  TailwindClass get surface4Hover =>
      this.._classList.add('bg-bg-surface-4-hover'); //
  TailwindClass get surface4Active =>
      this.._classList.add('bg-bg-surface-4-active'); //

  TailwindClass get maxWidthContentDesktop =>
      this.._classList.add('max-w-(--max-width-content-desktop)'); //

  TailwindClass get maxWidthReadContentDesktop =>
      this.._classList.add('max-w-[740px]'); //

  ///========================= STATES =========================///
  TailwindClass disabled([bool disabled = true]) =>
      this.._classList.add(disabled ? 'disabled' : '');

  ///========================= aspect-ratio =========================///
  TailwindClass get aspectRatioSquare =>
      this.._classList.add('aspect-square'); //
  TailwindClass get aspectVideo => this.._classList.add('aspect-video'); //
  TailwindClass get aspectAuto => this.._classList.add('aspect-auto'); //
  TailwindClass get aspect1_1 => this.._classList.add('aspect-1'); //
  TailwindClass get aspect5_4 => this.._classList.add('aspect-5/4'); //
  TailwindClass get aspect4_3 => this.._classList.add('aspect-4/3'); //
  TailwindClass get aspect3_2 => this.._classList.add('aspect-3/2'); //
  TailwindClass get aspect16_10 => this.._classList.add('aspect-16/10'); //
  TailwindClass get aspectGoldenRatioLandscape =>
      this.._classList.add('aspect-1.618/1'); //
  TailwindClass get aspect16_9 => this.._classList.add('aspect-16/9'); //
  TailwindClass get aspect2_1 => this.._classList.add('aspect-2/1'); //
  TailwindClass get aspect21_9 => this.._classList.add('aspect-21/9'); //
  TailwindClass get aspectA4Landscape =>
      this.._classList.add('aspect-11.67/8.27'); //
  TailwindClass get aspect4_5 => this.._classList.add('aspect-4/5'); //
  TailwindClass get aspect3_4 => this.._classList.add('aspect-3/4'); //
  TailwindClass get aspect2_3 => this.._classList.add('aspect-2/3'); //
  TailwindClass get aspect10_16 => this.._classList.add('aspect-10/16'); //
  TailwindClass get aspectGoldenRatioPortrait =>
      this.._classList.add('aspect-1/1.618'); //
  TailwindClass get aspect9_16 => this.._classList.add('aspect-9/16'); //
  TailwindClass get aspect1_2 => this.._classList.add('aspect-1/2'); //
  TailwindClass get aspect9_21 => this.._classList.add('aspect-9/21'); //
  TailwindClass get aspectA4Portrait =>
      this.._classList.add('aspect-8.27/11.67'); //

  ///========================= display =========================///
  TailwindClass get inline => this.._classList.add('inline'); //
  TailwindClass get block => this.._classList.add('block'); //
  TailwindClass get inlineBlock => this.._classList.add('inline-block'); //
  TailwindClass get flex => this.._classList.add('flex'); //
  TailwindClass get inlineFlex => this.._classList.add('inline-flex'); //
  TailwindClass get grid => this.._classList.add('grid'); //
  TailwindClass get inlineGrid => this.._classList.add('inline-grid'); //
  TailwindClass get contents => this.._classList.add('contents'); //
  TailwindClass get table => this.._classList.add('table'); //
  TailwindClass get inlineTable => this.._classList.add('inline-table'); //
  TailwindClass get listItem => this.._classList.add('list-item'); //

  TailwindClass hidden([bool hidden = true]) =>
      this.._classList.add(hidden ? 'hidden' : '');

  ///========================= object-fit =========================///
  TailwindClass get objectContain => this.._classList.add('object-contain'); //
  TailwindClass get objectCover => this.._classList.add('object-cover'); //
  TailwindClass get objectFill => this.._classList.add('object-fill'); //
  TailwindClass get objectNone => this.._classList.add('object-none'); //
  TailwindClass get objectScaleDown =>
      this.._classList.add('object-scale-down'); //

  ///========================= object-position =========================///
  TailwindClass get objectTopLeft => this.._classList.add('object-top-left'); //
  TailwindClass get objectTop => this.._classList.add('object-top'); //
  TailwindClass get objectTopRight =>
      this.._classList.add('object-top-right'); //
  TailwindClass get objectLeft => this.._classList.add('object-left'); //
  TailwindClass get objectCenter => this.._classList.add('object-center'); //
  TailwindClass get objectRight => this.._classList.add('object-right'); //
  TailwindClass get objectBottomLeft =>
      this.._classList.add('object-bottom-left'); //
  TailwindClass get objectBottom => this.._classList.add('object-bottom'); //
  TailwindClass get objectBottomRight =>
      this.._classList.add('object-bottom-right'); //

  ///========================= overscroll-behavior =========================///
  TailwindClass get overscrollAuto =>
      this.._classList.add('overscroll-auto'); //
  TailwindClass get overscrollContain =>
      this.._classList.add('overscroll-contain'); //
  TailwindClass get overscrollNone =>
      this.._classList.add('overscroll-none'); //
  TailwindClass get overscrollHorizontalAuto =>
      this.._classList.add('overscroll-x-auto'); //
  TailwindClass get overscrollHorizontalContain =>
      this.._classList.add('overscroll-x-contain'); //
  TailwindClass get overscrollHorizontalNone =>
      this.._classList.add('overscroll-x-none'); //
  TailwindClass get overscrollVerticalAuto =>
      this.._classList.add('overscroll-y-auto'); //
  TailwindClass get overscrollVerticalContain =>
      this.._classList.add('overscroll-y-contain'); //
  TailwindClass get overscrollVerticalNone =>
      this.._classList.add('overscroll-y-none'); //

  ///========================= overflow =========================///
  TailwindClass get overflowAuto => this.._classList.add('overflow-auto'); //
  TailwindClass get overflowHidden =>
      this.._classList.add('overflow-hidden'); //
  TailwindClass get overflowClip => this.._classList.add('overflow-clip'); //
  TailwindClass get overflowVisible =>
      this.._classList.add('overflow-visible'); //
  TailwindClass get overflowHorizontalAuto =>
      this.._classList.add('overflow-x-auto'); //
  TailwindClass get overflowHorizontalHidden =>
      this.._classList.add('overflow-x-hidden'); //
  TailwindClass get overflowHorizontalClip =>
      this.._classList.add('overflow-x-clip'); //
  TailwindClass get overflowHorizontalVisible =>
      this.._classList.add('overflow-x-visible'); //
  TailwindClass get overflowHorizontalScroll =>
      this.._classList.add('overflow-x-scroll'); //
  TailwindClass get overflowVerticalAuto =>
      this.._classList.add('overflow-y-auto'); //
  TailwindClass get overflowVerticalHidden =>
      this.._classList.add('overflow-y-hidden'); //
  TailwindClass get overflowVerticalClip =>
      this.._classList.add('overflow-y-clip'); //
  TailwindClass get overflowVerticalVisible =>
      this.._classList.add('overflow-y-visible'); //
  TailwindClass get overflowVerticalScroll =>
      this.._classList.add('overflow-y-scroll'); //

  ///========================= position =========================///
  TailwindClass get static => this.._classList.add('static'); //
  TailwindClass get fixed => this.._classList.add('fixed'); //
  TailwindClass get relative => this.._classList.add('relative');

  TailwindClass get absolute => this.._classList.add('absolute');

  TailwindClass get sticky => this.._classList.add('sticky'); //

  ///================ top / right / bottom / left =======================///
  TailwindClass get left => this.._classList.add('left-0'); //
  TailwindClass get left0 => this.._classList.add('left-0'); //
  TailwindClass get left1 => this.._classList.add('left-1'); //
  TailwindClass get left2 => this.._classList.add('left-2'); //
  TailwindClass get left4 => this.._classList.add('left-4'); //
  TailwindClass get left6 => this.._classList.add('left-6'); //
  TailwindClass get left8 => this.._classList.add('left-8'); //
  TailwindClass get left10 => this.._classList.add('left-10'); //
  TailwindClass get left12 => this.._classList.add('left-12'); //
  TailwindClass get left16 => this.._classList.add('left-16'); //
  TailwindClass get left20 => this.._classList.add('left-20'); //
  TailwindClass get left24 => this.._classList.add('left-24'); //
  TailwindClass get left28 => this.._classList.add('left-28'); //
  TailwindClass get left32 => this.._classList.add('left-32'); //
  TailwindClass get left36 => this.._classList.add('left-36'); //
  TailwindClass get left40 => this.._classList.add('left-40'); //

  TailwindClass get right => this.._classList.add('right-0'); //
  TailwindClass get right0 => this.._classList.add('right-0'); //
  TailwindClass get right1 => this.._classList.add('right-1'); //
  TailwindClass get right2 => this.._classList.add('right-2'); //
  TailwindClass get right4 => this.._classList.add('right-4'); //
  TailwindClass get right6 => this.._classList.add('right-6'); //
  TailwindClass get right8 => this.._classList.add('right-8'); //
  TailwindClass get right10 => this.._classList.add('right-10'); //
  TailwindClass get right12 => this.._classList.add('right-12'); //
  TailwindClass get right16 => this.._classList.add('right-16'); //
  TailwindClass get right20 => this.._classList.add('right-20'); //
  TailwindClass get right24 => this.._classList.add('right-24'); //
  TailwindClass get right28 => this.._classList.add('right-28'); //
  TailwindClass get right32 => this.._classList.add('right-32'); //
  TailwindClass get right36 => this.._classList.add('right-36'); //
  TailwindClass get right40 => this.._classList.add('right-40'); //

  TailwindClass get top => this.._classList.add('top-0'); //
  TailwindClass get top0 => this.._classList.add('top-0'); //
  TailwindClass get top1 => this.._classList.add('top-1'); //
  TailwindClass get top2 => this.._classList.add('top-2'); //
  TailwindClass get top4 => this.._classList.add('top-4'); //
  TailwindClass get top6 => this.._classList.add('top-6'); //
  TailwindClass get top8 => this.._classList.add('top-8'); //
  TailwindClass get top10 => this.._classList.add('top-10'); //
  TailwindClass get top12 => this.._classList.add('top-12'); //
  TailwindClass get top16 => this.._classList.add('top-16'); //
  TailwindClass get top20 => this.._classList.add('top-20'); //
  TailwindClass get top24 => this.._classList.add('top-24'); //
  TailwindClass get top28 => this.._classList.add('top-28'); //
  TailwindClass get top32 => this.._classList.add('top-32'); //
  TailwindClass get top36 => this.._classList.add('top-36'); //
  TailwindClass get top40 => this.._classList.add('top-40'); //

  TailwindClass get bottom => this.._classList.add('bottom-0'); //
  TailwindClass get bottom0 => this.._classList.add('bottom-0'); //
  TailwindClass get bottom1 => this.._classList.add('bottom-1'); //
  TailwindClass get bottom2 => this.._classList.add('bottom-2'); //
  TailwindClass get bottom4 => this.._classList.add('bottom-4'); //
  TailwindClass get bottom6 => this.._classList.add('bottom-6'); //
  TailwindClass get bottom8 => this.._classList.add('bottom-8'); //
  TailwindClass get bottom10 => this.._classList.add('bottom-10'); //
  TailwindClass get bottom12 => this.._classList.add('bottom-12'); //
  TailwindClass get bottom16 => this.._classList.add('bottom-16'); //
  TailwindClass get bottom20 => this.._classList.add('bottom-20'); //
  TailwindClass get bottom24 => this.._classList.add('bottom-24'); //
  TailwindClass get bottom28 => this.._classList.add('bottom-28'); //
  TailwindClass get bottom32 => this.._classList.add('bottom-32'); //
  TailwindClass get bottom36 => this.._classList.add('bottom-36'); //
  TailwindClass get bottom40 => this.._classList.add('bottom-40'); //

  TailwindClass get inset0 => this.._classList.add('inset-0'); //
  TailwindClass get insetFill => this.._classList.add('inset-0'); //
  TailwindClass get insetVertical0 => this.._classList.add('inset-y-0'); //
  TailwindClass get insetFillVertical => this.._classList.add('inset-y-0'); //
  TailwindClass get insetHorizontal0 => this.._classList.add('inset-x-0'); //
  TailwindClass get insetFillHorizontal => this.._classList.add('inset-x-0'); //

  ///========================= visibility =========================///
  TailwindClass visible([bool visible = true]) =>
      this.._classList.add(visible ? 'visible' : '');

  TailwindClass invisible([bool invisible = true]) =>
      this.._classList.add(invisible ? 'invisible' : '');

  TailwindClass collapse([bool collapse = true]) =>
      this.._classList.add(collapse ? 'collapse' : '');

  ///========================= z-index =========================///
  TailwindClass get zAuto => this.._classList.add('z-auto'); //
  TailwindClass get z1 => this.._classList.add('z-1'); //
  TailwindClass get z2 => this.._classList.add('z-2'); //
  TailwindClass get z3 => this.._classList.add('z-3'); //
  TailwindClass get z4 => this.._classList.add('z-4'); //
  TailwindClass get z5 => this.._classList.add('z-5'); //
  TailwindClass get z6 => this.._classList.add('z-6'); //
  TailwindClass get z7 => this.._classList.add('z-7'); //
  TailwindClass get z8 => this.._classList.add('z-8'); //
  TailwindClass get z9 => this.._classList.add('z-9'); //
  TailwindClass get z10 => this.._classList.add('z-10'); //

  ///========================= FLEX BOS & GRID =========================///
  TailwindClass get flexNone => this.._classList.add('flex-none'); //
  TailwindClass get flexInitial => this.._classList.add('flex-initial'); //
  TailwindClass get flex1 => this.._classList.add('flex-1'); //
  TailwindClass get flex2 => this.._classList.add('flex-2'); //
  TailwindClass get flex3 => this.._classList.add('flex-3'); //
  TailwindClass get flex4 => this.._classList.add('flex-4'); //
  TailwindClass get flex5 => this.._classList.add('flex-5'); //
  TailwindClass get flex6 => this.._classList.add('flex-6'); //
  TailwindClass get flex7 => this.._classList.add('flex-7'); //
  TailwindClass get flex8 => this.._classList.add('flex-8'); //
  TailwindClass get flex9 => this.._classList.add('flex-9'); //
  TailwindClass get flex10 => this.._classList.add('flex-10'); //
  TailwindClass get flexRow => this.._classList.add('flex-row'); //
  TailwindClass get flexRowReverse =>
      this.._classList.add('flex-row-reverse'); //
  TailwindClass get flexColumn => this.._classList.add('flex-col'); //
  TailwindClass get flexColumnReverse =>
      this.._classList.add('flex-row-reverse'); //
  TailwindClass get flexWrap => this.._classList.add('flex-wrap'); //
  TailwindClass get flexNoWrap => this.._classList.add('flex-nowrap'); //
  TailwindClass get flexWrapReverse =>
      this.._classList.add('flex-wrap-reverse'); //
  TailwindClass get flexGlow => this.._classList.add('grow'); //
  TailwindClass get flexGlow1 => this.._classList.add('grow-1'); //
  TailwindClass get flexGlow2 => this.._classList.add('grow-2'); //
  TailwindClass get flexGlow3 => this.._classList.add('grow-3'); //
  TailwindClass get flexGlow4 => this.._classList.add('grow-4'); //
  TailwindClass get flexGlow5 => this.._classList.add('grow-5'); //
  TailwindClass get flexGlow6 => this.._classList.add('grow-6'); //
  TailwindClass get flexGlow7 => this.._classList.add('grow-7'); //
  TailwindClass get flexGlow8 => this.._classList.add('grow-8'); //
  TailwindClass get flexGlow9 => this.._classList.add('grow-9'); //
  TailwindClass get flexGlow10 => this.._classList.add('grow-10'); //
  TailwindClass get flexShrink => this.._classList.add('shrink'); //
  TailwindClass get flexShrink0 => this.._classList.add('shrink-0'); //

  ///========================= Justify =========================///
  TailwindClass get justifyStart => this.._classList.add('justify-start'); //
  TailwindClass get justifyEnd => this.._classList.add('justify-end'); //
  TailwindClass get justifyEndSafe =>
      this.._classList.add('justify-end-safe'); //
  TailwindClass get justifyCenter => this.._classList.add('justify-center'); //
  TailwindClass get justifyCenterSafe =>
      this.._classList.add('justify-center-safe'); //
  TailwindClass get justifyBetween =>
      this.._classList.add('justify-between'); //
  TailwindClass get justifyAround => this.._classList.add('justify-around'); //
  TailwindClass get justifyEvenly => this.._classList.add('justify-evenly'); //
  TailwindClass get justifyStretch =>
      this.._classList.add('justify-stretch'); //
  TailwindClass get justifyBaseline =>
      this.._classList.add('justify-baseline'); //
  TailwindClass get justifyNormal => this.._classList.add('justify-normal'); //

  TailwindClass get justifyItemsStart =>
      this.._classList.add('justify-items-start'); //
  TailwindClass get justifyItemsEnd =>
      this.._classList.add('justify-items-end'); //
  TailwindClass get justifyItemsEndSafe =>
      this.._classList.add('justify-items-end-safe'); //
  TailwindClass get justifyItemsCenter =>
      this.._classList.add('justify-items-center'); //
  TailwindClass get justifyItemsCenterSafe =>
      this.._classList.add('justify-items-center-safe'); //
  TailwindClass get justifyItemsStretch =>
      this.._classList.add('justify-items-stretch'); //
  TailwindClass get justifyItemsNormal =>
      this.._classList.add('justify-items-normal'); //

  TailwindClass get justifySelfAuto =>
      this.._classList.add('justify-self-auto'); //
  TailwindClass get justifySelfStart =>
      this.._classList.add('justify-self-start'); //
  TailwindClass get justifySelfCenter =>
      this.._classList.add('justify-self-center'); //
  TailwindClass get justifySelfCenterSafe =>
      this.._classList.add('justify-self-center-safe'); //
  TailwindClass get justifySelfEnd =>
      this.._classList.add('justify-self-end'); //
  TailwindClass get justifySelfEndSafe =>
      this.._classList.add('justify-self-end-safe'); //
  TailwindClass get justifySelfStretch =>
      this.._classList.add('justify-self-stretch'); //

  TailwindClass get gridTemplateNone =>
      this.._classList.add('grid-cols-none'); //
  TailwindClass get gridTemplateSubgrid =>
      this.._classList.add('grid-cols-subgrid'); //
  TailwindClass get gridTemplateColumn1 =>
      this.._classList.add('grid-cols-1'); //
  TailwindClass get gridTemplateColumn2 =>
      this.._classList.add('grid-cols-2'); //
  TailwindClass get gridTemplateColumn3 =>
      this.._classList.add('grid-cols-3'); //
  TailwindClass get gridTemplateColumn4 =>
      this.._classList.add('grid-cols-4'); //
  TailwindClass get gridTemplateColumn5 =>
      this.._classList.add('grid-cols-5'); //
  TailwindClass get gridTemplateColumn6 =>
      this.._classList.add('grid-cols-6'); //
  TailwindClass get gridTemplateColumn7 =>
      this.._classList.add('grid-cols-7'); //
  TailwindClass get gridTemplateColumn8 =>
      this.._classList.add('grid-cols-8'); //

  TailwindClass get gridColumn1 => this.._classList.add('col-span-1'); //
  TailwindClass get gridColumn2 => this.._classList.add('col-span-2'); //
  TailwindClass get gridColumn3 => this.._classList.add('col-span-3'); //
  TailwindClass get gridColumn4 => this.._classList.add('col-span-4'); //
  TailwindClass get gridColumn5 => this.._classList.add('col-span-5'); //
  TailwindClass get gridColumn6 => this.._classList.add('col-span-6'); //
  TailwindClass get gridColumn7 => this.._classList.add('col-span-7'); //
  TailwindClass get gridColumn8 => this.._classList.add('col-span-8'); //
  TailwindClass get gridColumnFull => this.._classList.add('col-span-full'); //
  TailwindClass get gridColumnAuto => this.._classList.add('col-auto'); //

  TailwindClass get gridColumnStartAuto =>
      this.._classList.add('col-start-auto'); //
  TailwindClass get gridColumnStart1 => this.._classList.add('col-start-1'); //
  TailwindClass get gridColumnStart2 => this.._classList.add('col-start-2'); //
  TailwindClass get gridColumnStart3 => this.._classList.add('col-start-3'); //
  TailwindClass get gridColumnStart4 => this.._classList.add('col-start-4'); //
  TailwindClass get gridColumnStart5 => this.._classList.add('col-start-5'); //
  TailwindClass get gridColumnStart6 => this.._classList.add('col-start-6'); //
  TailwindClass get gridColumnStart7 => this.._classList.add('col-start-7'); //
  TailwindClass get gridColumnStart8 => this.._classList.add('col-start-8'); //

  TailwindClass get gridColumnEndAuto =>
      this.._classList.add('col-end-auto'); //
  TailwindClass get gridColumnEnd1 => this.._classList.add('col-end-1'); //
  TailwindClass get gridColumnEnd2 => this.._classList.add('col-end-2'); //
  TailwindClass get gridColumnEnd3 => this.._classList.add('col-end-3'); //
  TailwindClass get gridColumnEnd4 => this.._classList.add('col-end-4'); //
  TailwindClass get gridColumnEnd5 => this.._classList.add('col-end-5'); //
  TailwindClass get gridColumnEnd6 => this.._classList.add('col-end-6'); //
  TailwindClass get gridColumnEnd7 => this.._classList.add('col-end-7'); //
  TailwindClass get gridColumnEnd8 => this.._classList.add('col-end-8'); //

  TailwindClass get placeItemsStart =>
      this.._classList.add('place-items-start'); //
  TailwindClass get placeItemsEnd => this.._classList.add('place-items-end'); //
  TailwindClass get placeItemsEndSafe =>
      this.._classList.add('place-items-end-safe'); //
  TailwindClass get placeItemsCenter =>
      this.._classList.add('place-items-center'); //
  TailwindClass get placeItemsCenterSafe =>
      this.._classList.add('place-items-center-safe'); //
  TailwindClass get placeItemsBaseline =>
      this.._classList.add('place-items-baseline'); //
  TailwindClass get placeItemsStretch =>
      this.._classList.add('place-items-stretch'); //

  ///========================= align-content =========================///
  TailwindClass get contentNormal => this.._classList.add('content-normal'); //
  TailwindClass get contentCenter => this.._classList.add('content-center'); //
  TailwindClass get contentStart => this.._classList.add('content-start'); //
  TailwindClass get contentEnd => this.._classList.add('content-end'); //
  TailwindClass get contentBetween =>
      this.._classList.add('content-between'); //
  TailwindClass get contentAround => this.._classList.add('content-around'); //
  TailwindClass get contentEvenly => this.._classList.add('content-evenly'); //
  TailwindClass get contentBaseline =>
      this.._classList.add('content-baseline'); //
  TailwindClass get contentStretch =>
      this.._classList.add('content-stretch'); //

  ///========================= align-items =========================///
  TailwindClass get itemsStart => this.._classList.add('items-start'); //
  TailwindClass get itemsEnd => this.._classList.add('items-end'); //
  TailwindClass get itemsEndSafe => this.._classList.add('items-end-safe'); //
  TailwindClass get itemsCenter => this.._classList.add('items-center'); //
  TailwindClass get itemsCenterSafe =>
      this.._classList.add('items-center-safe'); //
  TailwindClass get itemsBaseline => this.._classList.add('items-baseline'); //
  TailwindClass get itemsBaselineLast =>
      this.._classList.add('items-baseline-last'); //
  TailwindClass get itemsStretch => this.._classList.add('items-stretch'); //

  ///========================= align-self =========================///
  TailwindClass get selfAuto => this.._classList.add('self-auto'); //
  TailwindClass get selfStart => this.._classList.add('self-start'); //
  TailwindClass get selfEnd => this.._classList.add('self-end'); //
  TailwindClass get selfEndSafe => this.._classList.add('self-end-safe'); //
  TailwindClass get selfCenter => this.._classList.add('self-center'); //
  TailwindClass get selfCenterSafe =>
      this.._classList.add('self-center-safe'); //
  TailwindClass get selfStretch => this.._classList.add('self-stretch'); //
  TailwindClass get selfBaseline => this.._classList.add('self-baseline'); //
  TailwindClass get selfBaselineLast =>
      this.._classList.add('self-baseline-last'); //

  ///========================= Spacing =========================///
  TailwindClass get padding1 => this.._classList.add('p-1'); //
  TailwindClass get padding2 => this.._classList.add('p-2'); //
  TailwindClass get padding4 => this.._classList.add('p-4'); //
  TailwindClass get padding6 => this.._classList.add('p-6'); //
  TailwindClass get padding8 => this.._classList.add('p-8'); //
  TailwindClass get padding10 => this.._classList.add('p-10'); //
  TailwindClass get padding12 => this.._classList.add('p-12'); //
  TailwindClass get padding16 => this.._classList.add('p-16'); //
  TailwindClass get padding20 => this.._classList.add('p-20'); //
  TailwindClass get padding24 => this.._classList.add('p-24'); //
  TailwindClass get padding28 => this.._classList.add('p-28'); //
  TailwindClass get padding32 => this.._classList.add('p-32'); //
  TailwindClass get padding36 => this.._classList.add('p-36'); //
  TailwindClass get padding40 => this.._classList.add('p-40'); //

  TailwindClass get paddingHorizontal1 => this.._classList.add('px-1'); //
  TailwindClass get paddingHorizontal2 => this.._classList.add('px-2'); //
  TailwindClass get paddingHorizontal4 => this.._classList.add('px-4'); //
  TailwindClass get paddingHorizontal6 => this.._classList.add('px-6'); //
  TailwindClass get paddingHorizontal8 => this.._classList.add('px-8'); //
  TailwindClass get paddingHorizontal10 => this.._classList.add('px-10'); //
  TailwindClass get paddingHorizontal12 => this.._classList.add('px-12'); //
  TailwindClass get paddingHorizontal16 => this.._classList.add('px-16'); //
  TailwindClass get paddingHorizontal20 => this.._classList.add('px-20'); //
  TailwindClass get paddingHorizontal24 => this.._classList.add('px-24'); //
  TailwindClass get paddingHorizontal28 => this.._classList.add('px-28'); //
  TailwindClass get paddingHorizontal32 => this.._classList.add('px-32'); //
  TailwindClass get paddingHorizontal36 => this.._classList.add('px-36'); //
  TailwindClass get paddingHorizontal40 => this.._classList.add('px-40'); //

  TailwindClass get paddingVertical1 => this.._classList.add('py-1'); //
  TailwindClass get paddingVertical2 => this.._classList.add('py-2'); //
  TailwindClass get paddingVertical4 => this.._classList.add('py-4'); //
  TailwindClass get paddingVertical6 => this.._classList.add('py-6'); //
  TailwindClass get paddingVertical8 => this.._classList.add('py-8'); //
  TailwindClass get paddingVertical10 => this.._classList.add('py-10'); //
  TailwindClass get paddingVertical12 => this.._classList.add('py-12'); //
  TailwindClass get paddingVertical16 => this.._classList.add('py-16'); //
  TailwindClass get paddingVertical20 => this.._classList.add('py-20'); //
  TailwindClass get paddingVertical24 => this.._classList.add('py-24'); //
  TailwindClass get paddingVertical28 => this.._classList.add('py-28'); //
  TailwindClass get paddingVertical32 => this.._classList.add('py-32'); //
  TailwindClass get paddingVertical36 => this.._classList.add('py-36'); //
  TailwindClass get paddingVertical40 => this.._classList.add('py-40'); //

  TailwindClass get paddingStart1 => this.._classList.add('ps-1'); //
  TailwindClass get paddingStart2 => this.._classList.add('ps-2'); //
  TailwindClass get paddingStart4 => this.._classList.add('ps-4'); //
  TailwindClass get paddingStart6 => this.._classList.add('ps-6'); //
  TailwindClass get paddingStart8 => this.._classList.add('ps-8'); //
  TailwindClass get paddingStart10 => this.._classList.add('ps-10'); //
  TailwindClass get paddingStart12 => this.._classList.add('ps-12'); //
  TailwindClass get paddingStart16 => this.._classList.add('ps-16'); //
  TailwindClass get paddingStart20 => this.._classList.add('ps-20'); //
  TailwindClass get paddingStart24 => this.._classList.add('ps-24'); //
  TailwindClass get paddingStart28 => this.._classList.add('ps-28'); //
  TailwindClass get paddingStart32 => this.._classList.add('ps-32'); //
  TailwindClass get paddingStart36 => this.._classList.add('ps-36'); //
  TailwindClass get paddingStart40 => this.._classList.add('ps-40'); //

  TailwindClass get paddingEnd1 => this.._classList.add('pe-1'); //
  TailwindClass get paddingEnd2 => this.._classList.add('pe-2'); //
  TailwindClass get paddingEnd4 => this.._classList.add('pe-4'); //
  TailwindClass get paddingEnd6 => this.._classList.add('pe-6'); //
  TailwindClass get paddingEnd8 => this.._classList.add('pe-8'); //
  TailwindClass get paddingEnd10 => this.._classList.add('pe-10'); //
  TailwindClass get paddingEnd12 => this.._classList.add('pe-12'); //
  TailwindClass get paddingEnd16 => this.._classList.add('pe-16'); //
  TailwindClass get paddingEnd20 => this.._classList.add('pe-20'); //
  TailwindClass get paddingEnd24 => this.._classList.add('pe-24'); //
  TailwindClass get paddingEnd28 => this.._classList.add('pe-28'); //
  TailwindClass get paddingEnd32 => this.._classList.add('pe-32'); //
  TailwindClass get paddingEnd36 => this.._classList.add('pe-36'); //
  TailwindClass get paddingEnd40 => this.._classList.add('pe-40'); //

  TailwindClass get paddingTop1 => this.._classList.add('pt-1'); //
  TailwindClass get paddingTop2 => this.._classList.add('pt-2'); //
  TailwindClass get paddingTop4 => this.._classList.add('pt-4'); //
  TailwindClass get paddingTop6 => this.._classList.add('pt-6'); //
  TailwindClass get paddingTop8 => this.._classList.add('pt-8'); //
  TailwindClass get paddingTop10 => this.._classList.add('pt-10'); //
  TailwindClass get paddingTop12 => this.._classList.add('pt-12'); //
  TailwindClass get paddingTop16 => this.._classList.add('pt-16'); //
  TailwindClass get paddingTop20 => this.._classList.add('pt-20'); //
  TailwindClass get paddingTop24 => this.._classList.add('pt-24'); //
  TailwindClass get paddingTop28 => this.._classList.add('pt-28'); //
  TailwindClass get paddingTop32 => this.._classList.add('pt-32'); //
  TailwindClass get paddingTop36 => this.._classList.add('pt-36'); //
  TailwindClass get paddingTop40 => this.._classList.add('pt-40'); //

  TailwindClass get paddingRight1 => this.._classList.add('pr-1'); //
  TailwindClass get paddingRight2 => this.._classList.add('pr-2'); //
  TailwindClass get paddingRight4 => this.._classList.add('pr-4'); //
  TailwindClass get paddingRight6 => this.._classList.add('pr-6'); //
  TailwindClass get paddingRight8 => this.._classList.add('pr-8'); //
  TailwindClass get paddingRight10 => this.._classList.add('pr-10'); //
  TailwindClass get paddingRight12 => this.._classList.add('pr-12'); //
  TailwindClass get paddingRight16 => this.._classList.add('pr-16'); //
  TailwindClass get paddingRight20 => this.._classList.add('pr-20'); //
  TailwindClass get paddingRight24 => this.._classList.add('pr-24'); //
  TailwindClass get paddingRight28 => this.._classList.add('pr-28'); //
  TailwindClass get paddingRight32 => this.._classList.add('pr-32'); //
  TailwindClass get paddingRight36 => this.._classList.add('pr-36'); //
  TailwindClass get paddingRight40 => this.._classList.add('pr-40'); //

  TailwindClass get paddingLeft1 => this.._classList.add('pl-1'); //
  TailwindClass get paddingLeft2 => this.._classList.add('pl-2'); //
  TailwindClass get paddingLeft4 => this.._classList.add('pl-4'); //
  TailwindClass get paddingLeft6 => this.._classList.add('pl-6'); //
  TailwindClass get paddingLeft8 => this.._classList.add('pl-8'); //
  TailwindClass get paddingLeft10 => this.._classList.add('pl-10'); //
  TailwindClass get paddingLeft12 => this.._classList.add('pl-12'); //
  TailwindClass get paddingLeft16 => this.._classList.add('pl-16'); //
  TailwindClass get paddingLeft20 => this.._classList.add('pl-20'); //
  TailwindClass get paddingLeft24 => this.._classList.add('pl-24'); //
  TailwindClass get paddingLeft28 => this.._classList.add('pl-28'); //
  TailwindClass get paddingLeft32 => this.._classList.add('pl-32'); //
  TailwindClass get paddingLeft36 => this.._classList.add('pl-36'); //
  TailwindClass get paddingLeft40 => this.._classList.add('pl-40'); //

  TailwindClass get paddingBottom1 => this.._classList.add('pb-1'); //
  TailwindClass get paddingBottom2 => this.._classList.add('pb-2'); //
  TailwindClass get paddingBottom4 => this.._classList.add('pb-4'); //
  TailwindClass get paddingBottom6 => this.._classList.add('pb-6'); //
  TailwindClass get paddingBottom8 => this.._classList.add('pb-8'); //
  TailwindClass get paddingBottom10 => this.._classList.add('pb-10'); //
  TailwindClass get paddingBottom12 => this.._classList.add('pb-12'); //
  TailwindClass get paddingBottom16 => this.._classList.add('pb-16'); //
  TailwindClass get paddingBottom20 => this.._classList.add('pb-20'); //
  TailwindClass get paddingBottom24 => this.._classList.add('pb-24'); //
  TailwindClass get paddingBottom28 => this.._classList.add('pb-28'); //
  TailwindClass get paddingBottom32 => this.._classList.add('pb-32'); //
  TailwindClass get paddingBottom36 => this.._classList.add('pb-36'); //
  TailwindClass get paddingBottom40 => this.._classList.add('pb-40'); //
  TailwindClass get paddingBottom60 => this.._classList.add('pb-60'); //
  TailwindClass get paddingBottom80 => this.._classList.add('pb-80'); //
  TailwindClass get paddingBottom100 => this.._classList.add('pb-100'); //

  TailwindClass get margin1 => this.._classList.add('m-1'); //
  TailwindClass get margin2 => this.._classList.add('m-2'); //
  TailwindClass get margin4 => this.._classList.add('m-4'); //
  TailwindClass get margin6 => this.._classList.add('m-6'); //
  TailwindClass get margin8 => this.._classList.add('m-8'); //
  TailwindClass get margin10 => this.._classList.add('m-10'); //
  TailwindClass get margin12 => this.._classList.add('m-12'); //
  TailwindClass get margin16 => this.._classList.add('m-16'); //
  TailwindClass get margin20 => this.._classList.add('m-20'); //
  TailwindClass get margin24 => this.._classList.add('m-24'); //
  TailwindClass get margin28 => this.._classList.add('m-28'); //
  TailwindClass get margin32 => this.._classList.add('m-32'); //
  TailwindClass get margin36 => this.._classList.add('m-36'); //
  TailwindClass get margin40 => this.._classList.add('m-40'); //

  TailwindClass get marginHorizontal1 => this.._classList.add('mx-1'); //
  TailwindClass get marginHorizontal2 => this.._classList.add('mx-2'); //
  TailwindClass get marginHorizontal4 => this.._classList.add('mx-4'); //
  TailwindClass get marginHorizontal6 => this.._classList.add('mx-6'); //
  TailwindClass get marginHorizontal8 => this.._classList.add('mx-8'); //
  TailwindClass get marginHorizontal10 => this.._classList.add('mx-10'); //
  TailwindClass get marginHorizontal12 => this.._classList.add('mx-12'); //
  TailwindClass get marginHorizontal16 => this.._classList.add('mx-16'); //
  TailwindClass get marginHorizontal20 => this.._classList.add('mx-20'); //
  TailwindClass get marginHorizontal24 => this.._classList.add('mx-24'); //
  TailwindClass get marginHorizontal28 => this.._classList.add('mx-28'); //
  TailwindClass get marginHorizontal32 => this.._classList.add('mx-32'); //
  TailwindClass get marginHorizontal36 => this.._classList.add('mx-36'); //
  TailwindClass get marginHorizontal40 => this.._classList.add('mx-40'); //

  TailwindClass get marginVertical1 => this.._classList.add('my-1'); //
  TailwindClass get marginVertical2 => this.._classList.add('my-2'); //
  TailwindClass get marginVertical4 => this.._classList.add('my-4'); //
  TailwindClass get marginVertical6 => this.._classList.add('my-6'); //
  TailwindClass get marginVertical8 => this.._classList.add('my-8'); //
  TailwindClass get marginVertical10 => this.._classList.add('my-10'); //
  TailwindClass get marginVertical12 => this.._classList.add('my-12'); //
  TailwindClass get marginVertical16 => this.._classList.add('my-16'); //
  TailwindClass get marginVertical20 => this.._classList.add('my-20'); //
  TailwindClass get marginVertical24 => this.._classList.add('my-24'); //
  TailwindClass get marginVertical28 => this.._classList.add('my-28'); //
  TailwindClass get marginVertical32 => this.._classList.add('my-32'); //
  TailwindClass get marginVertical36 => this.._classList.add('my-36'); //
  TailwindClass get marginVertical40 => this.._classList.add('my-40'); //

  TailwindClass get marginStart1 => this.._classList.add('ms-1'); //
  TailwindClass get marginStart2 => this.._classList.add('ms-2'); //
  TailwindClass get marginStart4 => this.._classList.add('ms-4'); //
  TailwindClass get marginStart6 => this.._classList.add('ms-6'); //
  TailwindClass get marginStart8 => this.._classList.add('ms-8'); //
  TailwindClass get marginStart10 => this.._classList.add('ms-10'); //
  TailwindClass get marginStart12 => this.._classList.add('ms-12'); //
  TailwindClass get marginStart16 => this.._classList.add('ms-16'); //
  TailwindClass get marginStart20 => this.._classList.add('ms-20'); //
  TailwindClass get marginStart24 => this.._classList.add('ms-24'); //
  TailwindClass get marginStart28 => this.._classList.add('ms-28'); //
  TailwindClass get marginStart32 => this.._classList.add('ms-32'); //
  TailwindClass get marginStart36 => this.._classList.add('ms-36'); //
  TailwindClass get marginStart40 => this.._classList.add('ms-40'); //

  TailwindClass get marginEnd1 => this.._classList.add('me-1'); //
  TailwindClass get marginEnd2 => this.._classList.add('me-2'); //
  TailwindClass get marginEnd4 => this.._classList.add('me-4'); //
  TailwindClass get marginEnd6 => this.._classList.add('me-6'); //
  TailwindClass get marginEnd8 => this.._classList.add('me-8'); //
  TailwindClass get marginEnd10 => this.._classList.add('me-10'); //
  TailwindClass get marginEnd12 => this.._classList.add('me-12'); //
  TailwindClass get marginEnd16 => this.._classList.add('me-16'); //
  TailwindClass get marginEnd20 => this.._classList.add('me-20'); //
  TailwindClass get marginEnd24 => this.._classList.add('me-24'); //
  TailwindClass get marginEnd28 => this.._classList.add('me-28'); //
  TailwindClass get marginEnd32 => this.._classList.add('me-32'); //
  TailwindClass get marginEnd36 => this.._classList.add('me-36'); //
  TailwindClass get marginEnd40 => this.._classList.add('me-40'); //

  TailwindClass get marginTop1 => this.._classList.add('mt-1'); //
  TailwindClass get marginTop2 => this.._classList.add('mt-2'); //
  TailwindClass get marginTop4 => this.._classList.add('mt-4'); //
  TailwindClass get marginTop6 => this.._classList.add('mt-6'); //
  TailwindClass get marginTop8 => this.._classList.add('mt-8'); //
  TailwindClass get marginTop10 => this.._classList.add('mt-10'); //
  TailwindClass get marginTop12 => this.._classList.add('mt-12'); //
  TailwindClass get marginTop16 => this.._classList.add('mt-16'); //
  TailwindClass get marginTop20 => this.._classList.add('mt-20'); //
  TailwindClass get marginTop24 => this.._classList.add('mt-24'); //
  TailwindClass get marginTop28 => this.._classList.add('mt-28'); //
  TailwindClass get marginTop32 => this.._classList.add('mt-32'); //
  TailwindClass get marginTop36 => this.._classList.add('mt-36'); //
  TailwindClass get marginTop40 => this.._classList.add('mt-40'); //
  TailwindClass get marginTop60 => this.._classList.add('mt-60'); //
  TailwindClass get marginTop80 => this.._classList.add('mt-80'); //
  TailwindClass get marginTop100 => this.._classList.add('mt-100'); //

  TailwindClass get marginRight1 => this.._classList.add('mr-1'); //
  TailwindClass get marginRight2 => this.._classList.add('mr-2'); //
  TailwindClass get marginRight4 => this.._classList.add('mr-4'); //
  TailwindClass get marginRight6 => this.._classList.add('mr-6'); //
  TailwindClass get marginRight8 => this.._classList.add('mr-8'); //
  TailwindClass get marginRight10 => this.._classList.add('mr-10'); //
  TailwindClass get marginRight12 => this.._classList.add('mr-12'); //
  TailwindClass get marginRight16 => this.._classList.add('mr-16'); //
  TailwindClass get marginRight20 => this.._classList.add('mr-20'); //
  TailwindClass get marginRight24 => this.._classList.add('mr-24'); //
  TailwindClass get marginRight28 => this.._classList.add('mr-28'); //
  TailwindClass get marginRight32 => this.._classList.add('mr-32'); //
  TailwindClass get marginRight36 => this.._classList.add('mr-36'); //
  TailwindClass get marginRight40 => this.._classList.add('mr-40'); //

  TailwindClass get marginLeft1 => this.._classList.add('ml-1'); //
  TailwindClass get marginLeft2 => this.._classList.add('ml-2'); //
  TailwindClass get marginLeft4 => this.._classList.add('ml-4'); //
  TailwindClass get marginLeft6 => this.._classList.add('ml-6'); //
  TailwindClass get marginLeft8 => this.._classList.add('ml-8'); //
  TailwindClass get marginLeft10 => this.._classList.add('ml-10'); //
  TailwindClass get marginLeft12 => this.._classList.add('ml-12'); //
  TailwindClass get marginLeft16 => this.._classList.add('ml-16'); //
  TailwindClass get marginLeft20 => this.._classList.add('ml-20'); //
  TailwindClass get marginLeft24 => this.._classList.add('ml-24'); //
  TailwindClass get marginLeft28 => this.._classList.add('ml-28'); //
  TailwindClass get marginLeft32 => this.._classList.add('ml-32'); //
  TailwindClass get marginLeft36 => this.._classList.add('ml-36'); //
  TailwindClass get marginLeft40 => this.._classList.add('ml-40'); //

  TailwindClass get marginBottom1 => this.._classList.add('mb-1'); //
  TailwindClass get marginBottom2 => this.._classList.add('mb-2'); //
  TailwindClass get marginBottom4 => this.._classList.add('mb-4'); //
  TailwindClass get marginBottom6 => this.._classList.add('mb-6'); //
  TailwindClass get marginBottom8 => this.._classList.add('mb-8'); //
  TailwindClass get marginBottom10 => this.._classList.add('mb-10'); //
  TailwindClass get marginBottom12 => this.._classList.add('mb-12'); //
  TailwindClass get marginBottom16 => this.._classList.add('mb-16'); //
  TailwindClass get marginBottom20 => this.._classList.add('mb-20'); //
  TailwindClass get marginBottom24 => this.._classList.add('mb-24'); //
  TailwindClass get marginBottom28 => this.._classList.add('mb-28'); //
  TailwindClass get marginBottom32 => this.._classList.add('mb-32'); //
  TailwindClass get marginBottom36 => this.._classList.add('mb-36'); //
  TailwindClass get marginBottom40 => this.._classList.add('mb-40'); //

  TailwindClass get gap1 => this.._classList.add('gap-1'); //
  TailwindClass get gap2 => this.._classList.add('gap-2'); //
  TailwindClass get gap4 => this.._classList.add('gap-4'); //
  TailwindClass get gap6 => this.._classList.add('gap-6'); //
  TailwindClass get gap8 => this.._classList.add('gap-8'); //
  TailwindClass get gap10 => this.._classList.add('gap-10'); //
  TailwindClass get gap12 => this.._classList.add('gap-12'); //
  TailwindClass get gap16 => this.._classList.add('gap-16'); //
  TailwindClass get gap20 => this.._classList.add('gap-20'); //
  TailwindClass get gap24 => this.._classList.add('gap-24'); //
  TailwindClass get gap28 => this.._classList.add('gap-28'); //
  TailwindClass get gap32 => this.._classList.add('gap-32'); //
  TailwindClass get gap36 => this.._classList.add('gap-36'); //
  TailwindClass get gap40 => this.._classList.add('gap-40'); //
  TailwindClass get gap50 => this.._classList.add('gap-50'); //
  TailwindClass get gap60 => this.._classList.add('gap-60'); //
  TailwindClass get gap70 => this.._classList.add('gap-70'); //
  TailwindClass get gap80 => this.._classList.add('gap-80'); //
  TailwindClass get gap90 => this.._classList.add('gap-90'); //
  TailwindClass get gap100 => this.._classList.add('gap-100'); //

  ///========================= Sizing =========================///
  TailwindClass get width8 => this.._classList.add('width-8'); //
  TailwindClass get width12 => this.._classList.add('width-12'); //
  TailwindClass get width16 => this.._classList.add('width-16'); //
  TailwindClass get width20 => this.._classList.add('width-20'); //
  TailwindClass get width24 => this.._classList.add('width-24'); //
  TailwindClass get width28 => this.._classList.add('width-28'); //
  TailwindClass get width32 => this.._classList.add('width-32'); //
  TailwindClass get width36 => this.._classList.add('width-36'); //
  TailwindClass get width40 => this.._classList.add('width-40'); //
  TailwindClass get width48 => this.._classList.add('width-48'); //
  TailwindClass get width56 => this.._classList.add('width-56'); //
  TailwindClass get width64 => this.._classList.add('width-64'); //
  TailwindClass get width72 => this.._classList.add('width-72'); //
  TailwindClass get width3xs => this.._classList.add('w-3xs'); //
  TailwindClass get width2xs => this.._classList.add('w-2xs'); //
  TailwindClass get width1xs => this.._classList.add('w-xs'); //
  TailwindClass get widthSm => this.._classList.add('w-sm'); //
  TailwindClass get widthMd => this.._classList.add('w-md'); //
  TailwindClass get widthLg => this.._classList.add('w-lg'); //
  TailwindClass get width1xl => this.._classList.add('w-xl'); //
  TailwindClass get width2xl => this.._classList.add('w-2xl'); //
  TailwindClass get width3xl => this.._classList.add('w-3xl'); //
  TailwindClass get width4xl => this.._classList.add('w-4xl'); //
  TailwindClass get width5xl => this.._classList.add('w-5xl'); //
  TailwindClass get width6xl => this.._classList.add('w-6xl'); //
  TailwindClass get width7xl => this.._classList.add('w-7xl'); //
  TailwindClass get widthAuto => this.._classList.add('w-auto'); //
  TailwindClass get widthFull => this.._classList.add('w-full'); //
  TailwindClass get widthScreen => this.._classList.add('w-screen'); //
  TailwindClass get widthMin => this.._classList.add('w-min'); //
  TailwindClass get widthMax => this.._classList.add('w-max'); //
  TailwindClass get widthFit => this.._classList.add('w-fit'); //

  TailwindClass get minWidth8 => this.._classList.add('min-w-8'); //
  TailwindClass get minWidth12 => this.._classList.add('min-w-12'); //
  TailwindClass get minWidth16 => this.._classList.add('min-w-16'); //
  TailwindClass get minWidth20 => this.._classList.add('min-w-20'); //
  TailwindClass get minWidth24 => this.._classList.add('min-w-24'); //
  TailwindClass get minWidth28 => this.._classList.add('min-w-28'); //
  TailwindClass get minWidth32 => this.._classList.add('min-w-32'); //
  TailwindClass get minWidth36 => this.._classList.add('min-w-36'); //
  TailwindClass get minWidth40 => this.._classList.add('min-w-40'); //
  TailwindClass get minWidth48 => this.._classList.add('min-w-48'); //
  TailwindClass get minWidth56 => this.._classList.add('min-w-56'); //
  TailwindClass get minWidth64 => this.._classList.add('min-w-64'); //
  TailwindClass get minWidth72 => this.._classList.add('min-w-72'); //  Tailwind
  TailwindClass get minWidth3xs => this.._classList.add('min-w-3xs'); //
  TailwindClass get minWidth2xs => this.._classList.add('min-w-2xs'); //
  TailwindClass get minWidth1xs => this.._classList.add('min-w-xs'); //
  TailwindClass get minWidthSm => this.._classList.add('min-w-sm'); //
  TailwindClass get minWidthMd => this.._classList.add('min-w-md'); //
  TailwindClass get minWidthLg => this.._classList.add('min-w-lg'); //
  TailwindClass get minWidth1xl => this.._classList.add('min-w-xl'); //
  TailwindClass get minWidth2xl => this.._classList.add('min-w-2xl'); //
  TailwindClass get minWidth3xl => this.._classList.add('min-w-3xl'); //
  TailwindClass get minWidth4xl => this.._classList.add('min-w-4xl'); //
  TailwindClass get minWidth5xl => this.._classList.add('min-w-5xl'); //
  TailwindClass get minWidth6xl => this.._classList.add('min-w-6xl'); //
  TailwindClass get minWidth7xl => this.._classList.add('min-w-7xl'); //
  TailwindClass get minWidthAuto => this.._classList.add('min-w-auto'); //
  TailwindClass get minWidthFull => this.._classList.add('min-w-full'); //
  TailwindClass get minWidthScreen => this.._classList.add('min-w-screen'); //
  TailwindClass get minWidthMin => this.._classList.add('min-w-min'); //
  TailwindClass get minWidthMax => this.._classList.add('min-w-max'); //
  TailwindClass get minWidthFit => this.._classList.add('min-w-fit'); //

  TailwindClass get maxWidth8 => this.._classList.add('max-w-8'); //
  TailwindClass get maxWidth12 => this.._classList.add('max-w-12'); //
  TailwindClass get maxWidth16 => this.._classList.add('max-w-16'); //
  TailwindClass get maxWidth20 => this.._classList.add('max-w-20'); //
  TailwindClass get maxWidth24 => this.._classList.add('max-w-24'); //
  TailwindClass get maxWidth28 => this.._classList.add('max-w-28'); //
  TailwindClass get maxWidth32 => this.._classList.add('max-w-32'); //
  TailwindClass get maxWidth36 => this.._classList.add('max-w-36'); //
  TailwindClass get maxWidth40 => this.._classList.add('max-w-40'); //
  TailwindClass get maxWidth48 => this.._classList.add('max-w-48'); //
  TailwindClass get maxWidth56 => this.._classList.add('max-w-56'); //
  TailwindClass get maxWidth64 => this.._classList.add('max-w-64'); //
  TailwindClass get maxWidth72 => this.._classList.add('max-w-72'); //
  TailwindClass get maxWidth3xs => this.._classList.add('max-w-3xs'); //
  TailwindClass get maxWidth2xs => this.._classList.add('max-w-2xs'); //
  TailwindClass get maxWidth1xs => this.._classList.add('max-w-xs'); //
  TailwindClass get maxWidthSm => this.._classList.add('max-w-sm'); //
  TailwindClass get maxWidthMd => this.._classList.add('max-w-md'); //
  TailwindClass get maxWidthLg => this.._classList.add('max-w-lg'); //
  TailwindClass get maxWidth1xl => this.._classList.add('max-w-xl'); //
  TailwindClass get maxWidth2xl => this.._classList.add('max-w-2xl'); //
  TailwindClass get maxWidth3xl => this.._classList.add('max-w-3xl'); //
  TailwindClass get maxWidth4xl => this.._classList.add('max-w-4xl'); //
  TailwindClass get maxWidth5xl => this.._classList.add('max-w-5xl'); //
  TailwindClass get maxWidth6xl => this.._classList.add('max-w-6xl'); //
  TailwindClass get maxWidth7xl => this.._classList.add('max-w-7xl'); //
  TailwindClass get maxWidthAuto => this.._classList.add('max-w-auto'); //
  TailwindClass get maxWidthFull => this.._classList.add('max-w-full'); //
  TailwindClass get maxWidthScreen => this.._classList.add('max-w-screen'); //
  TailwindClass get maxWidthMin => this.._classList.add('max-w-max'); //
  TailwindClass get maxWidthMax => this.._classList.add('max-w-max'); //
  TailwindClass get maxWidthFit => this.._classList.add('max-w-fit'); //

  TailwindClass get height8 => this.._classList.add('h-8'); //
  TailwindClass get height12 => this.._classList.add('h-12'); //
  TailwindClass get height16 => this.._classList.add('h-16'); //
  TailwindClass get height20 => this.._classList.add('h-20'); //
  TailwindClass get height24 => this.._classList.add('h-24'); //
  TailwindClass get height28 => this.._classList.add('h-28'); //
  TailwindClass get height32 => this.._classList.add('h-32'); //
  TailwindClass get height36 => this.._classList.add('h-36'); //
  TailwindClass get height40 => this.._classList.add('h-40'); //
  TailwindClass get height48 => this.._classList.add('h-48'); //
  TailwindClass get height56 => this.._classList.add('h-56'); //
  TailwindClass get height64 => this.._classList.add('h-64'); //
  TailwindClass get height72 => this.._classList.add('h-72'); //  Tailwind
  TailwindClass get height3xs => this.._classList.add('h-3xs'); //
  TailwindClass get height2xs => this.._classList.add('h-2xs'); //
  TailwindClass get height1xs => this.._classList.add('h-xs'); //
  TailwindClass get heightSm => this.._classList.add('h-sm'); //
  TailwindClass get heightMd => this.._classList.add('h-md'); //
  TailwindClass get heightLg => this.._classList.add('h-lg'); //
  TailwindClass get height1xl => this.._classList.add('h-xl'); //
  TailwindClass get height2xl => this.._classList.add('h-2xl'); //
  TailwindClass get height3xl => this.._classList.add('h-3xl'); //
  TailwindClass get height4xl => this.._classList.add('h-4xl'); //
  TailwindClass get height5xl => this.._classList.add('h-5xl'); //
  TailwindClass get height6xl => this.._classList.add('h-6xl'); //
  TailwindClass get height7xl => this.._classList.add('h-7xl'); //
  TailwindClass get heightAuto => this.._classList.add('h-auto'); //
  TailwindClass get heightFull => this.._classList.add('h-full'); //
  TailwindClass get heightScreen => this.._classList.add('h-screen'); //
  TailwindClass get heightMin => this.._classList.add('h-min'); //
  TailwindClass get heightMax => this.._classList.add('h-max'); //
  TailwindClass get heightFit => this.._classList.add('h-fit'); //

  TailwindClass get minHeight8 => this.._classList.add('min-h-8'); //
  TailwindClass get minHeight12 => this.._classList.add('min-h-12'); //
  TailwindClass get minHeight16 => this.._classList.add('min-h-16'); //
  TailwindClass get minHeight20 => this.._classList.add('min-h-20'); //
  TailwindClass get minHeight24 => this.._classList.add('min-h-24'); //
  TailwindClass get minHeight28 => this.._classList.add('min-h-28'); //
  TailwindClass get minHeight32 => this.._classList.add('min-h-32'); //
  TailwindClass get minHeight36 => this.._classList.add('min-h-36'); //
  TailwindClass get minHeight40 => this.._classList.add('min-h-40'); //
  TailwindClass get minHeight48 => this.._classList.add('min-h-48'); //
  TailwindClass get minHeight56 => this.._classList.add('min-h-56'); //
  TailwindClass get minHeight64 => this.._classList.add('min-h-64'); //
  TailwindClass get minHeight72 =>
      this.._classList.add('min-h-72'); //  Tailwind
  TailwindClass get minHeight3xs => this.._classList.add('min-h-3xs'); //
  TailwindClass get minHeight2xs => this.._classList.add('min-h-2xs'); //
  TailwindClass get minHeight1xs => this.._classList.add('min-h-xs'); //
  TailwindClass get minHeightSm => this.._classList.add('min-h-sm'); //
  TailwindClass get minHeightMd => this.._classList.add('min-h-md'); //
  TailwindClass get minHeightLg => this.._classList.add('min-h-lg'); //
  TailwindClass get minHeight1xl => this.._classList.add('min-h-xl'); //
  TailwindClass get minHeight2xl => this.._classList.add('min-h-2xl'); //
  TailwindClass get minHeight3xl => this.._classList.add('min-h-3xl'); //
  TailwindClass get minHeight4xl => this.._classList.add('min-h-4xl'); //
  TailwindClass get minHeight5xl => this.._classList.add('min-h-5xl'); //
  TailwindClass get minHeight6xl => this.._classList.add('min-h-6xl'); //
  TailwindClass get minHeight7xl => this.._classList.add('min-h-7xl'); //
  TailwindClass get minHeightAuto => this.._classList.add('min-h-auto'); //
  TailwindClass get minHeightFull => this.._classList.add('min-h-full'); //
  TailwindClass get minHeightScreen => this.._classList.add('min-h-screen'); //
  TailwindClass get minHeightMin => this.._classList.add('min-h-min'); //
  TailwindClass get minHeightMax => this.._classList.add('min-h-max'); //
  TailwindClass get minHeightFit => this.._classList.add('min-h-fit'); //

  TailwindClass get maxHeight8 => this.._classList.add('max-h-8'); //
  TailwindClass get maxHeight12 => this.._classList.add('max-h-12'); //
  TailwindClass get maxHeight16 => this.._classList.add('max-h-16'); //
  TailwindClass get maxHeight20 => this.._classList.add('max-h-20'); //
  TailwindClass get maxHeight24 => this.._classList.add('max-h-24'); //
  TailwindClass get maxHeight28 => this.._classList.add('max-h-28'); //
  TailwindClass get maxHeight32 => this.._classList.add('max-h-32'); //
  TailwindClass get maxHeight36 => this.._classList.add('max-h-36'); //
  TailwindClass get maxHeight40 => this.._classList.add('max-h-40'); //
  TailwindClass get maxHeight48 => this.._classList.add('max-h-48'); //
  TailwindClass get maxHeight56 => this.._classList.add('max-h-56'); //
  TailwindClass get maxHeight64 => this.._classList.add('max-h-64'); //
  TailwindClass get maxHeight72 =>
      this.._classList.add('max-h-72'); //  Tailwind
  TailwindClass get maxHeight3xs => this.._classList.add('max-h-3xs'); //
  TailwindClass get maxHeight2xs => this.._classList.add('max-h-2xs'); //
  TailwindClass get maxHeight1xs => this.._classList.add('max-h-xs'); //
  TailwindClass get maxHeightSm => this.._classList.add('max-h-sm'); //
  TailwindClass get maxHeightMd => this.._classList.add('max-h-md'); //
  TailwindClass get maxHeightLg => this.._classList.add('max-h-lg'); //
  TailwindClass get maxHeight1xl => this.._classList.add('max-h-xl'); //
  TailwindClass get maxHeight2xl => this.._classList.add('max-h-2xl'); //
  TailwindClass get maxHeight3xl => this.._classList.add('max-h-3xl'); //
  TailwindClass get maxHeight4xl => this.._classList.add('max-h-4xl'); //
  TailwindClass get maxHeight5xl => this.._classList.add('max-h-5xl'); //
  TailwindClass get maxHeight6xl => this.._classList.add('max-h-6xl'); //
  TailwindClass get maxHeight7xl => this.._classList.add('max-h-7xl'); //
  TailwindClass get maxHeightAuto => this.._classList.add('max-h-auto'); //
  TailwindClass get maxHeightFull => this.._classList.add('max-h-full'); //
  TailwindClass get maxHeightScreen => this.._classList.add('max-h-screen'); //
  TailwindClass get maxHeightMin => this.._classList.add('max-h-max'); //
  TailwindClass get maxHeightMax => this.._classList.add('max-h-max'); //
  TailwindClass get maxHeightFit => this.._classList.add('max-h-fit'); //

  TailwindClass get size8 => this.._classList.add('size-8'); //
  TailwindClass get size12 => this.._classList.add('size-12'); //
  TailwindClass get size16 => this.._classList.add('size-16'); //
  TailwindClass get size20 => this.._classList.add('size-20'); //
  TailwindClass get size24 => this.._classList.add('size-24'); //
  TailwindClass get size28 => this.._classList.add('size-28'); //
  TailwindClass get size32 => this.._classList.add('size-32'); //
  TailwindClass get size36 => this.._classList.add('size-36'); //
  TailwindClass get size40 => this.._classList.add('size-40'); //
  TailwindClass get size48 => this.._classList.add('size-48'); //
  TailwindClass get size56 => this.._classList.add('size-56'); //
  TailwindClass get size64 => this.._classList.add('size-64'); //
  TailwindClass get size72 => this.._classList.add('size-72'); //
  TailwindClass get size3xs => this.._classList.add('size-3xs'); //
  TailwindClass get size2xs => this.._classList.add('size-2xs'); //
  TailwindClass get size1xs => this.._classList.add('size-xs'); //
  TailwindClass get sizeSm => this.._classList.add('size-sm'); //
  TailwindClass get sizeMd => this.._classList.add('size-md'); //
  TailwindClass get sizeLg => this.._classList.add('size-lg'); //
  TailwindClass get size1xl => this.._classList.add('size-xl'); //
  TailwindClass get size2xl => this.._classList.add('size-2xl'); //
  TailwindClass get size3xl => this.._classList.add('size-3xl'); //
  TailwindClass get size4xl => this.._classList.add('size-4xl'); //
  TailwindClass get size5xl => this.._classList.add('size-5xl'); //
  TailwindClass get size6xl => this.._classList.add('size-6xl'); //
  TailwindClass get size7xl => this.._classList.add('size-7xl'); //
  TailwindClass get sizeAuto => this.._classList.add('size-auto'); //
  TailwindClass get sizeFull => this.._classList.add('size-full'); //
  TailwindClass get sizeMin => this.._classList.add('size-min'); //
  TailwindClass get sizeMax => this.._classList.add('size-max'); //
  TailwindClass get sizeFit => this.._classList.add('size-fit'); //

  ///========================= TYPOGRAPHY =========================///
  TailwindClass get fontThin => this.._classList.add('font-thin'); //
  TailwindClass get fontExtraLight =>
      this.._classList.add('font-extralight'); //
  TailwindClass get fontLight => this.._classList.add('font-light'); //
  TailwindClass get fontLightImportant =>
      this.._classList.add('!font-light'); //
  TailwindClass get fontNormal => this.._classList.add('font-normal'); //
  TailwindClass get fontNormalImportant =>
      this.._classList.add('!font-normal'); //
  TailwindClass get fontMedium => this.._classList.add('font-medium'); //
  TailwindClass get fontMediumImportant =>
      this.._classList.add('!font-medium'); //
  TailwindClass get fontSemibold => this.._classList.add('font-semibold'); //
  TailwindClass get fontSemiboldImportant =>
      this.._classList.add('!font-semibold'); //
  TailwindClass get fontBold => this.._classList.add('font-bold'); //
  TailwindClass get fontBoldImportant => this.._classList.add('!font-bold'); //
  TailwindClass get fontExtraBold => this.._classList.add('font-extrabold'); //
  TailwindClass get fontExtraBoldImportant =>
      this.._classList.add('!font-extrabold'); //
  TailwindClass get fontBlack => this.._classList.add('font-black'); //
  TailwindClass get fontBlackImportant =>
      this.._classList.add('!font-black'); //
  ///========================= line-clamp =========================///
  TailwindClass get maxLine1 => this.._classList.add('line-clamp-1'); //
  TailwindClass get maxLine2 => this.._classList.add('line-clamp-2'); //
  TailwindClass get maxLine3 => this.._classList.add('line-clamp-3'); //
  TailwindClass get maxLine4 => this.._classList.add('line-clamp-4'); //
  TailwindClass get maxLine5 => this.._classList.add('line-clamp-5'); //
  TailwindClass get maxLine6 => this.._classList.add('line-clamp-6'); //

  ///========================= text-align =========================///
  TailwindClass get textLeft => this.._classList.add('text-left'); //
  TailwindClass get textCenter => this.._classList.add('text-center'); //
  TailwindClass get textRight => this.._classList.add('text-right'); //
  TailwindClass get textJustify => this.._classList.add('text-justify'); //
  TailwindClass get textStart => this.._classList.add('text-start'); //
  TailwindClass get textEnd => this.._classList.add('text-end'); //

  TailwindClass get textBlack => this.._classList.add('text-black'); //
  TailwindClass get textWhite => this.._classList.add('text-white'); //
  TailwindClass get textTransparent =>
      this.._classList.add('text-transparent'); //

  ///========================= text-underline-offset =========================///
  TailwindClass get underlineOffsetAuto =>
      this.._classList.add('underline-offset-auto'); //
  TailwindClass get underlineOffset1 =>
      this.._classList.add('underline-offset-1'); //
  TailwindClass get underlineOffset2 =>
      this.._classList.add('underline-offset-2'); //
  TailwindClass get underlineOffset3 =>
      this.._classList.add('underline-offset-3'); //
  TailwindClass get underlineOffset4 =>
      this.._classList.add('underline-offset-4'); //
  TailwindClass get underlineOffset5 =>
      this.._classList.add('underline-offset-5'); //

  ///========================= text-transform =========================///
  TailwindClass get uppercase => this.._classList.add('uppercase'); //
  TailwindClass get lowercase => this.._classList.add('lowercase'); //
  TailwindClass get capitalize => this.._classList.add('capitalize'); //

  ///========================= text-overflow =========================///
  TailwindClass get truncate => this.._classList.add('truncate'); //
  TailwindClass get textEllipsis => this.._classList.add('text-ellipsis'); //
  TailwindClass get textClip => this.._classList.add('text-clip'); //

  ///========================= text-wrap =========================///
  TailwindClass get textWrap => this.._classList.add('text-wrap'); //
  TailwindClass get textNoWrap => this.._classList.add('text-nowrap'); //
  TailwindClass get textBalance => this.._classList.add('text-balance'); //
  TailwindClass get textPretty => this.._classList.add('text-pretty'); //

  ///========================= text-indent =========================///
  TailwindClass get textIndent1 => this.._classList.add('textIndent1'); //
  TailwindClass get textIndent2 => this.._classList.add('textIndent2'); //
  TailwindClass get textIndent3 => this.._classList.add('textIndent3'); //
  TailwindClass get textIndent4 => this.._classList.add('textIndent4'); //
  TailwindClass get textIndent5 => this.._classList.add('textIndent5'); //
  TailwindClass get textIndent6 => this.._classList.add('textIndent6'); //
  TailwindClass get textIndent7 => this.._classList.add('textIndent7'); //
  TailwindClass get textIndent8 => this.._classList.add('textIndent8'); //
  TailwindClass get textIndent10 => this.._classList.add('textIndent10'); //
  TailwindClass get textIndent12 => this.._classList.add('textIndent12'); //
  TailwindClass get textIndent16 => this.._classList.add('textIndent16'); //
  TailwindClass get textIndent20 => this.._classList.add('textIndent20'); //
  TailwindClass get textIndent24 => this.._classList.add('textIndent24'); //
  TailwindClass get textIndent28 => this.._classList.add('textIndent28'); //
  TailwindClass get textIndent32 => this.._classList.add('textIndent32'); //
  TailwindClass get textIndent36 => this.._classList.add('textIndent36'); //
  TailwindClass get textIndent40 => this.._classList.add('textIndent40'); //

  ///========================= BACKGROUNDS =========================///
  TailwindClass get bgTransparent => this.._classList.add('bg-transparent'); //
  TailwindClass get bgBlack => this.._classList.add('bg-black'); //
  TailwindClass get bgWhite => this.._classList.add('bg-white'); //
  TailwindClass get bgAuto => this.._classList.add('bg-auto'); //
  TailwindClass get bgCover => this.._classList.add('bg-cover'); //
  TailwindClass get bgContain => this.._classList.add('bg-contain'); //

  ///========================= BORDERS =========================///
  TailwindClass get rounded2 => this.._classList.add('rounded-xs'); //
  TailwindClass get rounded4 => this.._classList.add('rounded-sm'); //
  TailwindClass get rounded6 => this.._classList.add('rounded-md'); //
  TailwindClass get rounded8 => this.._classList.add('rounded-lg'); //
  TailwindClass get rounded12 => this.._classList.add('rounded-xl'); //
  TailwindClass get rounded16 => this.._classList.add('rounded-2xl'); //
  TailwindClass get rounded20 => this.._classList.add('rounded-[20px]'); //
  TailwindClass get rounded24 => this.._classList.add('rounded-3xl'); //
  TailwindClass get rounded32 => this.._classList.add('rounded-4xl'); //
  TailwindClass get roundedXs => this.._classList.add('rounded-xs'); //
  TailwindClass get roundedSm => this.._classList.add('rounded-sm'); //
  TailwindClass get roundedMd => this.._classList.add('rounded-md'); //
  TailwindClass get roundedLg => this.._classList.add('rounded-lg'); //
  TailwindClass get rounded1xl => this.._classList.add('rounded-xl'); //
  TailwindClass get rounded2xl => this.._classList.add('rounded-2xl'); //
  TailwindClass get rounded3xl => this.._classList.add('rounded-3xl'); //
  TailwindClass get rounded4xl => this.._classList.add('rounded-4xl'); //
  TailwindClass get roundedNone => this.._classList.add('rounded-none'); //
  TailwindClass get roundedFull => this.._classList.add('rounded-full'); //

  TailwindClass get roundedStart2 => this.._classList.add('rounded-s-xs'); //
  TailwindClass get roundedStart4 => this.._classList.add('rounded-s-sm'); //
  TailwindClass get roundedStart6 => this.._classList.add('rounded-s-md'); //
  TailwindClass get roundedStart8 => this.._classList.add('rounded-s-lg'); //
  TailwindClass get roundedStart12 => this.._classList.add('rounded-s-xl'); //
  TailwindClass get roundedStart16 => this.._classList.add('rounded-s-2xl'); //
  TailwindClass get roundedStart20 =>
      this.._classList.add('rounded-s-[20px]'); //
  TailwindClass get roundedStart24 => this.._classList.add('rounded-s-3xl'); //
  TailwindClass get roundedStart32 => this.._classList.add('rounded-s-4xl'); //
  TailwindClass get roundedStartXs =>
      this.._classList.add('rounded-s-xs'); //2432
  TailwindClass get roundedStartSm =>
      this.._classList.add('rounded-s-sm'); //2432
  TailwindClass get roundedStartMd =>
      this.._classList.add('rounded-s-md'); //2432
  TailwindClass get roundedStartLg =>
      this.._classList.add('rounded-s-lg'); //2432
  TailwindClass get roundedStart1xl =>
      this.._classList.add('rounded-s-xl'); //2432
  TailwindClass get roundedStart2xl =>
      this.._classList.add('rounded-s-2xl'); //2432
  TailwindClass get roundedStart3xl =>
      this.._classList.add('rounded-s-3xl'); //2432
  TailwindClass get roundedStart4xl => this.._classList.add('rounded-s-4xl'); //
  TailwindClass get roundedStartNone =>
      this.._classList.add('rounded-s-none'); //
  TailwindClass get roundedStartFull =>
      this.._classList.add('rounded-s-full'); //

  TailwindClass get roundedEnd2 => this.._classList.add('rounded-e-xs'); //
  TailwindClass get roundedEnd4 => this.._classList.add('rounded-e-sm'); //
  TailwindClass get roundedEnd6 => this.._classList.add('rounded-e-md'); //
  TailwindClass get roundedEnd8 => this.._classList.add('rounded-e-lg'); //
  TailwindClass get roundedEnd12 => this.._classList.add('rounded-e-xl'); //
  TailwindClass get roundedEnd16 => this.._classList.add('rounded-e-2xl'); //
  TailwindClass get roundedEnd24 => this.._classList.add('rounded-e-3xl'); //
  TailwindClass get roundedEnd32 => this.._classList.add('rounded-e-4xl'); //
  TailwindClass get roundedEndXs => this.._classList.add('rounded-e-xs'); //
  TailwindClass get roundedEndSm => this.._classList.add('rounded-e-sm'); //
  TailwindClass get roundedEndMd => this.._classList.add('rounded-e-md'); //
  TailwindClass get roundedEndLg => this.._classList.add('rounded-e-lg'); //
  TailwindClass get roundedEnd1xl => this.._classList.add('rounded-e-xl'); //
  TailwindClass get roundedEnd2xl => this.._classList.add('rounded-e-2xl'); //
  TailwindClass get roundedEnd3xl => this.._classList.add('rounded-e-3xl'); //
  TailwindClass get roundedEnd4xl => this.._classList.add('rounded-e-4xl'); //
  TailwindClass get roundedEndNone => this.._classList.add('rounded-e-none'); //
  TailwindClass get roundedEndFull => this.._classList.add('rounded-e-full'); //

  TailwindClass get roundedTop2 => this.._classList.add('rounded-t-xs'); //
  TailwindClass get roundedTop4 => this.._classList.add('rounded-t-sm'); //
  TailwindClass get roundedTop6 => this.._classList.add('rounded-t-md'); //
  TailwindClass get roundedTop8 => this.._classList.add('rounded-t-lg'); //
  TailwindClass get roundedTop12 => this.._classList.add('rounded-t-xl'); //
  TailwindClass get roundedTop16 => this.._classList.add('rounded-t-2xl'); //
  TailwindClass get roundedTop24 => this.._classList.add('rounded-t-3xl'); //
  TailwindClass get roundedTop32 => this.._classList.add('rounded-t-4xl'); //
  TailwindClass get roundedTopXs => this.._classList.add('rounded-t-xs'); //
  TailwindClass get roundedTopSm => this.._classList.add('rounded-t-sm'); //
  TailwindClass get roundedTopMd => this.._classList.add('rounded-t-md'); //
  TailwindClass get roundedTopLg => this.._classList.add('rounded-t-lg'); //
  TailwindClass get roundedTop1xl => this.._classList.add('rounded-t-xl'); //
  TailwindClass get roundedTop2xl => this.._classList.add('rounded-t-2xl'); //
  TailwindClass get roundedTop3xl => this.._classList.add('rounded-t-3xl'); //
  TailwindClass get roundedTop4xl => this.._classList.add('rounded-t-4xl'); //
  TailwindClass get roundedTopNone => this.._classList.add('rounded-t-none'); //
  TailwindClass get roundedTopFull => this.._classList.add('rounded-t-full'); //

  TailwindClass get roundedRight2 => this.._classList.add('rounded-r-xs'); //
  TailwindClass get roundedRight4 => this.._classList.add('rounded-r-sm'); //
  TailwindClass get roundedRight6 => this.._classList.add('rounded-r-md'); //
  TailwindClass get roundedRight8 => this.._classList.add('rounded-r-lg'); //
  TailwindClass get roundedRight12 => this.._classList.add('rounded-r-xl'); //
  TailwindClass get roundedRight16 => this.._classList.add('rounded-r-2xl'); //
  TailwindClass get roundedRight24 => this.._classList.add('rounded-r-3xl'); //
  TailwindClass get roundedRight32 => this.._classList.add('rounded-r-4xl'); //
  TailwindClass get roundedRightXs => this.._classList.add('rounded-r-xs'); //
  TailwindClass get roundedRightSm => this.._classList.add('rounded-r-sm'); //
  TailwindClass get roundedRightMd => this.._classList.add('rounded-r-md'); //
  TailwindClass get roundedRightLg => this.._classList.add('rounded-r-lg'); //
  TailwindClass get roundedRight1xl => this.._classList.add('rounded-r-xl'); //
  TailwindClass get roundedRight2xl => this.._classList.add('rounded-r-2xl'); //
  TailwindClass get roundedRight3xl => this.._classList.add('rounded-r-3xl'); //
  TailwindClass get roundedRight4xl => this.._classList.add('rounded-r-4xl'); //
  TailwindClass get roundedRightNone =>
      this.._classList.add('rounded-r-none'); //
  TailwindClass get roundedRightFull =>
      this.._classList.add('rounded-r-full'); //

  TailwindClass get roundedBottom2 => this.._classList.add('rounded-b-xs'); //
  TailwindClass get roundedBottom4 => this.._classList.add('rounded-b-sm'); //
  TailwindClass get roundedBottom6 => this.._classList.add('rounded-b-md'); //
  TailwindClass get roundedBottom8 => this.._classList.add('rounded-b-lg'); //
  TailwindClass get roundedBottom12 => this.._classList.add('rounded-b-xl'); //
  TailwindClass get roundedBottom16 => this.._classList.add('rounded-b-2xl'); //
  TailwindClass get roundedBottom24 => this.._classList.add('rounded-b-3xl'); //
  TailwindClass get roundedBottom32 => this.._classList.add('rounded-b-4xl'); //
  TailwindClass get roundedBottomXs => this.._classList.add('rounded-b-xs'); //
  TailwindClass get roundedBottomSm => this.._classList.add('rounded-b-sm'); //
  TailwindClass get roundedBottomMd => this.._classList.add('rounded-b-md'); //
  TailwindClass get roundedBottomLg => this.._classList.add('rounded-b-lg'); //
  TailwindClass get roundedBottom1xl => this.._classList.add('rounded-b-xl'); //
  TailwindClass get roundedBottom2xl =>
      this.._classList.add('rounded-b-2xl'); //
  TailwindClass get roundedBottom3xl =>
      this.._classList.add('rounded-b-3xl'); //
  TailwindClass get roundedBottom4xl =>
      this.._classList.add('rounded-b-4xl'); //
  TailwindClass get roundedBottomNone =>
      this.._classList.add('rounded-b-none'); //
  TailwindClass get roundedBottomFull =>
      this.._classList.add('rounded-b-full'); //

  TailwindClass get roundedLeft2 => this.._classList.add('rounded-l-xs'); //
  TailwindClass get roundedLeft4 => this.._classList.add('rounded-l-sm'); //
  TailwindClass get roundedLeft6 => this.._classList.add('rounded-l-md'); //
  TailwindClass get roundedLeft8 => this.._classList.add('rounded-l-lg'); //
  TailwindClass get roundedLeft12 => this.._classList.add('rounded-l-xl'); //
  TailwindClass get roundedLeft16 => this.._classList.add('rounded-l-2xl'); //
  TailwindClass get roundedLeft24 => this.._classList.add('rounded-l-3xl'); //
  TailwindClass get roundedLeft32 => this.._classList.add('rounded-l-4xl'); //
  TailwindClass get roundedLeftXs => this.._classList.add('rounded-l-xs'); //
  TailwindClass get roundedLeftSm => this.._classList.add('rounded-l-sm'); //
  TailwindClass get roundedLeftMd => this.._classList.add('rounded-l-md'); //
  TailwindClass get roundedLeftLg => this.._classList.add('rounded-l-lg'); //
  TailwindClass get roundedLeft1xl => this.._classList.add('rounded-l-xl'); //
  TailwindClass get roundedLeft2xl => this.._classList.add('rounded-l-2xl'); //
  TailwindClass get roundedLeft3xl => this.._classList.add('rounded-l-3xl'); //
  TailwindClass get roundedLeft4xl => this.._classList.add('rounded-l-4xl'); //
  TailwindClass get roundedLeftNone =>
      this.._classList.add('rounded-l-none'); //
  TailwindClass get roundedLeftFull =>
      this.._classList.add('rounded-l-full'); //

  TailwindClass get roundedTopLeft2 => this.._classList.add('rounded-tl-xs'); //
  TailwindClass get roundedTopLeft4 => this.._classList.add('rounded-tl-sm'); //
  TailwindClass get roundedTopLeft6 => this.._classList.add('rounded-tl-md'); //
  TailwindClass get roundedTopLeft8 => this.._classList.add('rounded-tl-lg'); //
  TailwindClass get roundedTopLeft12 =>
      this.._classList.add('rounded-tl-xl'); //
  TailwindClass get roundedTopLeft16 =>
      this.._classList.add('rounded-tl-2xl'); //
  TailwindClass get roundedTopLeft24 =>
      this.._classList.add('rounded-tl-3xl'); //
  TailwindClass get roundedTopLeft32 =>
      this.._classList.add('rounded-tl-4xl'); //
  TailwindClass get roundedTopLeftXs =>
      this.._classList.add('rounded-tl-xs'); //
  TailwindClass get roundedTopLeftSm =>
      this.._classList.add('rounded-tl-sm'); //
  TailwindClass get roundedTopLeftMd =>
      this.._classList.add('rounded-tl-md'); //
  TailwindClass get roundedTopLeftLg =>
      this.._classList.add('rounded-tl-lg'); //
  TailwindClass get roundedTopLeft1xl =>
      this.._classList.add('rounded-tl-xl'); //
  TailwindClass get roundedTopLeft2xl =>
      this.._classList.add('rounded-tl-2xl'); //
  TailwindClass get roundedTopLeft3xl =>
      this.._classList.add('rounded-tl-3xl'); //
  TailwindClass get roundedTopLeft4xl =>
      this.._classList.add('rounded-tl-4xl'); //
  TailwindClass get roundedTopLeftNone =>
      this.._classList.add('rounded-tl-none'); //
  TailwindClass get roundedTopLeftFull =>
      this.._classList.add('rounded-tl-full'); //

  TailwindClass get roundedTopRight2 =>
      this.._classList.add('rounded-tr-xs'); //
  TailwindClass get roundedTopRight4 =>
      this.._classList.add('rounded-tr-sm'); //
  TailwindClass get roundedTopRight6 =>
      this.._classList.add('rounded-tr-md'); //
  TailwindClass get roundedTopRight8 =>
      this.._classList.add('rounded-tr-lg'); //
  TailwindClass get roundedTopRight12 =>
      this.._classList.add('rounded-tr-xl'); //
  TailwindClass get roundedTopRight16 =>
      this.._classList.add('rounded-tr-2xl'); //
  TailwindClass get roundedTopRight24 =>
      this.._classList.add('rounded-tr-3xl'); //
  TailwindClass get roundedTopRight32 =>
      this.._classList.add('rounded-tr-4xl'); //
  TailwindClass get roundedTopRightXs =>
      this.._classList.add('rounded-tr-xs'); //
  TailwindClass get roundedTopRightSm =>
      this.._classList.add('rounded-tr-sm'); //
  TailwindClass get roundedTopRightMd =>
      this.._classList.add('rounded-tr-md'); //
  TailwindClass get roundedTopRightLg =>
      this.._classList.add('rounded-tr-lg'); //
  TailwindClass get roundedTopRight1xl =>
      this.._classList.add('rounded-tr-xl'); //
  TailwindClass get roundedTopRight2xl =>
      this.._classList.add('rounded-tr-2xl'); //
  TailwindClass get roundedTopRight3xl =>
      this.._classList.add('rounded-tr-3xl'); //
  TailwindClass get roundedTopRight4xl =>
      this.._classList.add('rounded-tr-4xl'); //
  TailwindClass get roundedTopRightNone =>
      this.._classList.add('rounded-tr-none'); //
  TailwindClass get roundedTopRightFull =>
      this.._classList.add('rounded-tr-full'); //

  TailwindClass get roundedBottomRight2 =>
      this.._classList.add('rounded-br-xs'); //
  TailwindClass get roundedBottomRight4 =>
      this.._classList.add('rounded-br-sm'); //
  TailwindClass get roundedBottomRight6 =>
      this.._classList.add('rounded-br-md'); //
  TailwindClass get roundedBottomRight8 =>
      this.._classList.add('rounded-br-lg'); //
  TailwindClass get roundedBottomRight12 =>
      this.._classList.add('rounded-br-xl'); //
  TailwindClass get roundedBottomRight16 =>
      this.._classList.add('rounded-br-2xl'); //
  TailwindClass get roundedBottomRight24 =>
      this.._classList.add('rounded-br-3xl'); //
  TailwindClass get roundedBottomRight32 =>
      this.._classList.add('rounded-br-4xl'); //
  TailwindClass get roundedBottomRightXs =>
      this.._classList.add('rounded-br-xs'); //
  TailwindClass get roundedBottomRightSm =>
      this.._classList.add('rounded-br-sm'); //
  TailwindClass get roundedBottomRightMd =>
      this.._classList.add('rounded-br-md'); //
  TailwindClass get roundedBottomRightLg =>
      this.._classList.add('rounded-br-lg'); //
  TailwindClass get roundedBottomRight1xl =>
      this.._classList.add('rounded-br-xl'); //
  TailwindClass get roundedBottomRight2xl =>
      this.._classList.add('rounded-br-2xl'); //
  TailwindClass get roundedBottomRight3xl =>
      this.._classList.add('rounded-br-3xl'); //
  TailwindClass get roundedBottomRight4xl =>
      this.._classList.add('rounded-br-4xl'); //
  TailwindClass get roundedBottomRightNone =>
      this.._classList.add('rounded-br-none'); //
  TailwindClass get roundedBottomRightFull =>
      this.._classList.add('rounded-br-full'); //

  TailwindClass get roundedBottomLeft2 =>
      this.._classList.add('rounded-bl-xs'); //
  TailwindClass get roundedBottomLeft4 =>
      this.._classList.add('rounded-bl-sm'); //
  TailwindClass get roundedBottomLeft6 =>
      this.._classList.add('rounded-bl-md'); //
  TailwindClass get roundedBottomLeft8 =>
      this.._classList.add('rounded-bl-lg'); //
  TailwindClass get roundedBottomLeft12 =>
      this.._classList.add('rounded-bl-xl'); //
  TailwindClass get roundedBottomLeft16 =>
      this.._classList.add('rounded-bl-2xl'); //
  TailwindClass get roundedBottomLeft24 =>
      this.._classList.add('rounded-bl-3xl'); //
  TailwindClass get roundedBottomLeft32 =>
      this.._classList.add('rounded-bl-4xl'); //
  TailwindClass get roundedBottomLeftXs =>
      this.._classList.add('rounded-bl-xs'); //
  TailwindClass get roundedBottomLeftSm =>
      this.._classList.add('rounded-bl-sm'); //
  TailwindClass get roundedBottomLeftMd =>
      this.._classList.add('rounded-bl-md'); //
  TailwindClass get roundedBottomLeftLg =>
      this.._classList.add('rounded-bl-lg'); //
  TailwindClass get roundedBottomLeft1xl =>
      this.._classList.add('rounded-bl-xl'); //
  TailwindClass get roundedBottomLeft2xl =>
      this.._classList.add('rounded-bl-2xl'); //
  TailwindClass get roundedBottomLeft3xl =>
      this.._classList.add('rounded-bl-3xl'); //
  TailwindClass get roundedBottomLeft4xl =>
      this.._classList.add('rounded-bl-4xl'); //
  TailwindClass get roundedBottomLeftNone =>
      this.._classList.add('rounded-bl-none'); //
  TailwindClass get roundedBottomLeftFull =>
      this.._classList.add('rounded-bl-full'); //

  TailwindClass get border0_5 => this.._classList.add('border-[0.5px]'); //
  TailwindClass get border1 => this.._classList.add('border-1'); //
  TailwindClass get border1_5 => this.._classList.add('border-1.5'); //
  TailwindClass get border2 => this.._classList.add('border-2'); //
  TailwindClass get border4 => this.._classList.add('border-4'); //
  TailwindClass get borderInline0_5 =>
      this.._classList.add('border-x-[0.5px]'); //
  TailwindClass get borderInline1 => this.._classList.add('border-x-1'); //
  TailwindClass get borderInline1_5 => this.._classList.add('border-x-1.5'); //
  TailwindClass get borderInline2 => this.._classList.add('border-x-2'); //
  TailwindClass get borderInline4 => this.._classList.add('border-x-4'); //
  TailwindClass get borderOuter0_5 =>
      this.._classList.add('border-y-[0.5px]'); //
  TailwindClass get borderOuter1 => this.._classList.add('border-y-1'); //
  TailwindClass get borderOuter1_5 => this.._classList.add('border-y-1.5'); //
  TailwindClass get borderOuter2 => this.._classList.add('border-y-2'); //
  TailwindClass get borderOuter4 => this.._classList.add('border-y-4'); //
  TailwindClass get borderInlineStart0_5 =>
      this.._classList.add('border-s-[0.5px]'); //
  TailwindClass get borderInlineStart1 => this.._classList.add('border-s-1'); //
  TailwindClass get borderInlineStart1_5 =>
      this.._classList.add('border-s-1.5'); //
  TailwindClass get borderInlineStart2 => this.._classList.add('border-s-2'); //
  TailwindClass get borderInlineStart4 => this.._classList.add('border-s-4'); //
  TailwindClass get borderInlineEnd0_5 =>
      this.._classList.add('border-e-[0.5px]'); //
  TailwindClass get borderInlineEnd1 => this.._classList.add('border-e-1'); //
  TailwindClass get borderInlineEnd1_5 =>
      this.._classList.add('border-e-1.5'); //
  TailwindClass get borderInlineEnd2 => this.._classList.add('border-e-2'); //
  TailwindClass get borderInlineEnd4 => this.._classList.add('border-e-4'); //
  TailwindClass get borderTop0_5 => this.._classList.add('border-t-[0.5px]'); //
  TailwindClass get borderTop1 => this.._classList.add('border-t-1'); //
  TailwindClass get borderTop1_5 => this.._classList.add('border-t-1.5'); //
  TailwindClass get borderTop2 => this.._classList.add('border-t-2'); //
  TailwindClass get borderTop4 => this.._classList.add('border-t-4'); //
  TailwindClass get borderRight0_5 =>
      this.._classList.add('border-r-[0.5px]'); //
  TailwindClass get borderRight1 => this.._classList.add('border-r-1'); //
  TailwindClass get borderRight1_5 => this.._classList.add('border-r-1.5'); //
  TailwindClass get borderRight2 => this.._classList.add('border-r-2'); //
  TailwindClass get borderRight4 => this.._classList.add('border-r-4'); //
  TailwindClass get borderBottom0_5 =>
      this.._classList.add('border-b-[0.5px]'); //
  TailwindClass get borderBottom1 => this.._classList.add('border-b-1'); //
  TailwindClass get borderBottom1_5 => this.._classList.add('border-b-1.5'); //
  TailwindClass get borderBottom2 => this.._classList.add('border-b-2'); //
  TailwindClass get borderBottom4 => this.._classList.add('border-b-4'); //
  TailwindClass get borderLeft0_5 =>
      this.._classList.add('border-l-[0.5px]'); //
  TailwindClass get borderLeft1 => this.._classList.add('border-l-1'); //
  TailwindClass get borderLeft1_5 => this.._classList.add('border-l-1.5'); //
  TailwindClass get borderLeft2 => this.._classList.add('border-l-2'); //
  TailwindClass get borderLeft4 => this.._classList.add('border-l-4'); //
  TailwindClass get borderHorizontal0_5 =>
      this.._classList.add('border-x-[0.5px]'); //
  TailwindClass get borderHorizontal1 => this.._classList.add('border-x-1'); //
  TailwindClass get borderHorizontal1_5 =>
      this.._classList.add('border-x-1.5'); //
  TailwindClass get borderHorizontal2 => this.._classList.add('border-x-2'); //
  TailwindClass get borderHorizontal4 => this.._classList.add('border-x-4'); //
  TailwindClass get borderVertical0_5 =>
      this.._classList.add('border-y-[0.5px]'); //
  TailwindClass get borderVertical1 => this.._classList.add('border-y-1'); //
  TailwindClass get borderVertical1_5 =>
      this.._classList.add('border-y-1.5'); //
  TailwindClass get borderVertical2 => this.._classList.add('border-y-2'); //
  TailwindClass get borderVertical4 => this.._classList.add('border-y-4'); //

  TailwindClass get borderBlack => this.._classList.add('border-black'); //
  TailwindClass get borderWhite => this.._classList.add('border-white'); //

  TailwindClass get borderSolid => this.._classList.add('border-solid'); //
  TailwindClass get borderDashed => this.._classList.add('border-dashed'); //
  TailwindClass get borderDotted => this.._classList.add('border-dotted'); //
  TailwindClass get borderDouble => this.._classList.add('border-double'); //
  TailwindClass get borderHidden => this.._classList.add('border-hidden'); //
  TailwindClass get borderNone => this.._classList.add('border-none'); //

  TailwindClass get divideVertical0_5 =>
      this.._classList.add('divide-x-[0.5px]'); //
  TailwindClass get divideVertical1 => this.._classList.add('divide-x-1'); //
  TailwindClass get divideVertical1_5 =>
      this.._classList.add('divide-x-1.5'); //
  TailwindClass get divideVertical2 => this.._classList.add('divide-x-2'); //
  TailwindClass get divideVertical4 => this.._classList.add('divide-x-4'); //
  TailwindClass get divideHorizontal0_5 =>
      this.._classList.add('divide-y-[0.5px]'); //
  TailwindClass get divideHorizontal1 => this.._classList.add('divide-y-1'); //
  TailwindClass get divideHorizontal1_5 =>
      this.._classList.add('divide-y-1.5'); //
  TailwindClass get divideHorizontal2 => this.._classList.add('divide-y-2'); //
  TailwindClass get divideHorizontal4 => this.._classList.add('divide-y-4'); //

  TailwindClass get divideBlack => this.._classList.add('divide-black'); //
  TailwindClass get divideWhite => this.._classList.add('divide-white'); //

  TailwindClass get divideSolid => this.._classList.add('divide-solid'); //
  TailwindClass get divideDashed => this.._classList.add('divide-dashed'); //
  TailwindClass get divideDotted => this.._classList.add('divide-dotted'); //
  TailwindClass get divideDouble => this.._classList.add('divide-double'); //
  TailwindClass get divideHidden => this.._classList.add('divide-hidden'); //
  TailwindClass get divideNone => this.._classList.add('divide-none'); //

  TailwindClass get outline0_5 =>
      this.._classList.add('outline outline-[0.5px]'); //
  TailwindClass get outline1 => this.._classList.add('outline outline-1'); //
  TailwindClass get outline1_5 =>
      this.._classList.add('outline outline-1.5'); //
  TailwindClass get outline2 => this.._classList.add('outline outline-2'); //
  TailwindClass get outline4 => this.._classList.add('outline outline-4'); //

  TailwindClass get outlineBlack =>
      this.._classList.add('outline outline-black'); //
  TailwindClass get outlineWhite =>
      this.._classList.add('outline outline-white'); //

  TailwindClass get outlineSolid =>
      this.._classList.add('outline outline-solid'); //
  TailwindClass get outlineDashed =>
      this.._classList.add('outline outline-dashed'); //
  TailwindClass get outlineDotted =>
      this.._classList.add('outline outline-dotted'); //
  TailwindClass get outlineDouble =>
      this.._classList.add('outline outline-double'); //
  TailwindClass get outlineHidden =>
      this.._classList.add('outline outline-hidden'); //
  TailwindClass get outlineNone =>
      this.._classList.add('outline outline-none'); //

  TailwindClass get outlineOffset0_5 =>
      this.._classList.add('outline-offset-[0.5px]'); //
  TailwindClass get outlineOffset1 =>
      this.._classList.add('outline-offset-1'); //
  TailwindClass get outlineOffset1_5 =>
      this.._classList.add('outline-offset-1.5'); //
  TailwindClass get outlineOffset2 =>
      this.._classList.add('outline-offset-2'); //
  TailwindClass get outlineOffset4 =>
      this.._classList.add('outline-offset-4'); //

  ///========================= EFFECTS =========================///
  TailwindClass get shadow2xs => this.._classList.add('shadow-2xs'); //
  TailwindClass get shadow1xs => this.._classList.add('shadow-xs'); //
  TailwindClass get shadowSm => this.._classList.add('shadow-sm'); //
  TailwindClass get shadowMd => this.._classList.add('shadow-md'); //
  TailwindClass get shadowLg => this.._classList.add('shadow-lg'); //
  TailwindClass get shadow1xl => this.._classList.add('shadow-xl'); //
  TailwindClass get shadow2xl => this.._classList.add('shadow-2xl'); //
  TailwindClass get shadowNone => this.._classList.add('shadow-none'); //

  TailwindClass get shadowBlack => this.._classList.add('shadow-black'); //
  TailwindClass get shadowWhite => this.._classList.add('shadow-white'); //

  TailwindClass get ring0_5 => this.._classList.add('ring-[0.5px]'); //
  TailwindClass get ring1 => this.._classList.add('ring-1'); //
  TailwindClass get ring1_5 => this.._classList.add('ring-1.5'); //
  TailwindClass get ring2 => this.._classList.add('ring-2'); //
  TailwindClass get ring4 => this.._classList.add('ring-4'); //

  TailwindClass get ringBlack => this.._classList.add('ring-black'); //
  TailwindClass get ringWhite => this.._classList.add('ring-white'); //

  TailwindClass get opacity0 => this.._classList.add('opacity-0'); //
  TailwindClass get opacity1 => this.._classList.add('opacity-1'); //
  TailwindClass get opacity2 => this.._classList.add('opacity-2'); //
  TailwindClass get opacity3 => this.._classList.add('opacity-3'); //
  TailwindClass get opacity4 => this.._classList.add('opacity-4'); //
  TailwindClass get opacity5 => this.._classList.add('opacity-5'); //
  TailwindClass get opacity10 => this.._classList.add('opacity-10'); //
  TailwindClass get opacity15 => this.._classList.add('opacity-15'); //
  TailwindClass get opacity20 => this.._classList.add('opacity-20'); //
  TailwindClass get opacity25 => this.._classList.add('opacity-25'); //
  TailwindClass get opacity30 => this.._classList.add('opacity-30'); //
  TailwindClass get opacity35 => this.._classList.add('opacity-35'); //
  TailwindClass get opacity40 => this.._classList.add('opacity-40'); //
  TailwindClass get opacity45 => this.._classList.add('opacity-45'); //
  TailwindClass get opacity50 => this.._classList.add('opacity-50'); //
  TailwindClass get opacity60 => this.._classList.add('opacity-60'); //
  TailwindClass get opacity70 => this.._classList.add('opacity-70'); //
  TailwindClass get opacity80 => this.._classList.add('opacity-80'); //
  TailwindClass get opacity90 => this.._classList.add('opacity-90'); //
  TailwindClass get opacity100 => this.._classList.add('opacity-100'); //

  ///========================= transition-property =========================///
  TailwindClass get transition => this.._classList.add('transition'); //
  TailwindClass get transitionAll => this.._classList.add('transition-all'); //
  TailwindClass get transitionColors =>
      this.._classList.add('transition-colors'); //
  TailwindClass get transitionOpacity =>
      this.._classList.add('transition-opacity'); //
  TailwindClass get transitionShadow =>
      this.._classList.add('transition-shadow'); //
  TailwindClass get transitionTransform =>
      this.._classList.add('transition-transform'); //
  TailwindClass get transitionNone =>
      this.._classList.add('transition-none'); //

  ///========================= transition-behavior =========================///
  TailwindClass get transitionNormal =>
      this.._classList.add('transition-normal'); //
  TailwindClass get transitionDiscrete =>
      this.._classList.add('transition-discrete'); //

  ///========================= transition-duration =========================///
  TailwindClass get duration50ms => this.._classList.add('duration-50'); //
  TailwindClass get duration100ms => this.._classList.add('duration-100'); //
  TailwindClass get duration150ms => this.._classList.add('duration-150'); //
  TailwindClass get duration200ms => this.._classList.add('duration-200'); //
  TailwindClass get duration250ms => this.._classList.add('duration-250'); //
  TailwindClass get duration300ms => this.._classList.add('duration-300'); //
  TailwindClass get duration350ms => this.._classList.add('duration-350'); //
  TailwindClass get duration400ms => this.._classList.add('duration-400'); //
  TailwindClass get duration450ms => this.._classList.add('duration-450'); //
  TailwindClass get duration500ms => this.._classList.add('duration-500'); //
  TailwindClass get duration600ms => this.._classList.add('duration-600'); //
  TailwindClass get duration700ms => this.._classList.add('duration-700'); //
  TailwindClass get duration800ms => this.._classList.add('duration-800'); //
  TailwindClass get duration900ms => this.._classList.add('duration-900'); //
  TailwindClass get duration1000ms => this.._classList.add('duration-1000'); //

  ///====================== transition-timing-function ======================///
  TailwindClass get easeLinear => this.._classList.add('ease-linear'); //
  TailwindClass get easeIn => this.._classList.add('ease-in'); //
  TailwindClass get easeOut => this.._classList.add('ease-out'); //
  TailwindClass get easeInOut => this.._classList.add('ease-in-out'); //
  TailwindClass get easeInitial => this.._classList.add('ease-initial'); //

  ///========================= transition-delay =========================///
  TailwindClass get delay50ms => this.._classList.add('delay-50'); //
  TailwindClass get delay100ms => this.._classList.add('delay-100'); //
  TailwindClass get delay150ms => this.._classList.add('delay-150'); //
  TailwindClass get delay200ms => this.._classList.add('delay-200'); //
  TailwindClass get delay250ms => this.._classList.add('delay-250'); //
  TailwindClass get delay300ms => this.._classList.add('delay-300'); //
  TailwindClass get delay350ms => this.._classList.add('delay-350'); //
  TailwindClass get delay400ms => this.._classList.add('delay-400'); //
  TailwindClass get delay450ms => this.._classList.add('delay-450'); //
  TailwindClass get delay500ms => this.._classList.add('delay-500'); //
  TailwindClass get delay600ms => this.._classList.add('delay-600'); //
  TailwindClass get delay700ms => this.._classList.add('delay-700'); //
  TailwindClass get delay800ms => this.._classList.add('delay-800'); //
  TailwindClass get delay900ms => this.._classList.add('delay-900'); //
  TailwindClass get delay1000ms => this.._classList.add('delay-1000'); //

  ///========================= animation =========================///
  TailwindClass get animateSpin => this.._classList.add('animate-spin'); //
  TailwindClass get animatePing => this.._classList.add('animate-ping'); //
  TailwindClass get animatePulse => this.._classList.add('animate-pulse'); //
  TailwindClass get animateBounce => this.._classList.add('animate-bounce'); //
  TailwindClass get animateNone => this.._classList.add('animate-none'); //

  ///========================= transform-origin =========================///
  TailwindClass get originCenter => this.._classList.add('origin-center'); //
  TailwindClass get originTop => this.._classList.add('origin-top'); //
  TailwindClass get originTopRight =>
      this.._classList.add('origin-top-right'); //
  TailwindClass get originRight => this.._classList.add('origin-right'); //
  TailwindClass get originBottomRight =>
      this.._classList.add('origin-bottom-right'); //
  TailwindClass get originBottom => this.._classList.add('origin-bottom'); //
  TailwindClass get originBottomLeft =>
      this.._classList.add('origin-bottom-left'); //
  TailwindClass get originLeft => this.._classList.add('origin-left'); //
  TailwindClass get originTopLeft => this.._classList.add('origin-top-left'); //

  ///========================= cursor =========================///
  TailwindClass get cursorAuto => this.._classList.add('cursor-auto'); //
  TailwindClass get cursorDefault => this.._classList.add('cursor-default'); //
  TailwindClass get cursorPointer => this.._classList.add('cursor-pointer'); //
  TailwindClass get cursorWait => this.._classList.add('cursor-wait'); //
  TailwindClass get cursorText => this.._classList.add('cursor-text'); //
  TailwindClass get cursorMove => this.._classList.add('cursor-move'); //
  TailwindClass get cursorHelp => this.._classList.add('cursor-help'); //
  TailwindClass get cursorNotAllowed =>
      this.._classList.add('cursor-not-allowed'); //
  TailwindClass get cursorNone => this.._classList.add('cursor-none'); //
  TailwindClass get cursorContentMenu =>
      this.._classList.add('cursor-context-menu'); //
  TailwindClass get cursorProgress =>
      this.._classList.add('cursor-progress'); //
  TailwindClass get cursorCell => this.._classList.add('cursor-cell'); //
  TailwindClass get cursorCrossHair =>
      this.._classList.add('cursor-crosshair'); //
  TailwindClass get cursorAlias =>
      this.._classList.add('cursor-vertical-text'); //
  TailwindClass get cursorCopy => this.._classList.add('cursor-copy'); //
  TailwindClass get cursorNoDrop => this.._classList.add('cursor-no-drop'); //
  TailwindClass get cursorGrab => this.._classList.add('cursor-grab'); //
  TailwindClass get cursorGrabbing =>
      this.._classList.add('cursor-grabbing'); //
  TailwindClass get cursorAllScroll =>
      this.._classList.add('cursor-all-scroll'); //
  TailwindClass get cursorColumnResize =>
      this.._classList.add('cursor-col-resize'); //
  TailwindClass get cursorRowResize =>
      this.._classList.add('cursor-row-resize'); //
  TailwindClass get cursorZoomIn => this.._classList.add('cursor-zoom-in'); //
  TailwindClass get cursorZoomOut => this.._classList.add('cursor-zoom-out'); //

  ///========================= pointer-events =========================///
  TailwindClass get pointerEventsAuto =>
      this.._classList.add('pointer-events-auto'); //
  TailwindClass get pointerEventsNone =>
      this.._classList.add('pointer-events-none'); //

  ///=========================user-select =========================///
  TailwindClass get selectNone => this.._classList.add('select-none'); //
  TailwindClass get selectText => this.._classList.add('select-text'); //
  TailwindClass get selectAll => this.._classList.add('select-all'); //
  TailwindClass get selectAuto => this.._classList.add('select-auto'); //

  ///========================= resize =========================///
  TailwindClass get resizeNone => this.._classList.add('resize-none'); //
  TailwindClass get resize => this.._classList.add('resize'); //
  TailwindClass get resizeX => this.._classList.add('resize-x'); //
  TailwindClass get resizeY => this.._classList.add('resize-y'); //

  ///========================= scroll-behavior =========================///
  TailwindClass get scrollAuto => this.._classList.add('scroll-auto'); //
  TailwindClass get scrollSmooth => this.._classList.add('scroll-smooth'); //

  ///========================= scroll-margin =========================///
  TailwindClass get scrollMargin0 => this.._classList.add('scroll-m-0'); //
  TailwindClass get scrollMargin1 => this.._classList.add('scroll-m-1'); //
  TailwindClass get scrollMargin2 => this.._classList.add('scroll-m-2'); //
  TailwindClass get scrollMargin4 => this.._classList.add('scroll-m-4'); //
  TailwindClass get scrollMargin8 => this.._classList.add('scroll-m-8'); //
  TailwindClass get scrollMarginTop0 => this.._classList.add('scroll-mt-0'); //
  TailwindClass get scrollMarginTop1 => this.._classList.add('scroll-mt-1'); //
  TailwindClass get scrollMarginTop2 => this.._classList.add('scroll-mt-2'); //
  TailwindClass get scrollMarginTop4 => this.._classList.add('scroll-mt-4'); //
  TailwindClass get scrollMarginTop8 => this.._classList.add('scroll-mt-8'); //

  ///========================= scroll-padding =========================///
  TailwindClass get scrollPadding0 => this.._classList.add('scroll-p-0'); //
  TailwindClass get scrollPadding1 => this.._classList.add('scroll-p-1'); //
  TailwindClass get scrollPadding2 => this.._classList.add('scroll-p-2'); //
  TailwindClass get scrollPadding4 => this.._classList.add('scroll-p-4'); //
  TailwindClass get scrollPadding8 => this.._classList.add('scroll-p-8'); //
  TailwindClass get scrollPaddingTop0 => this.._classList.add('scroll-pt-0'); //
  TailwindClass get scrollPaddingTop1 => this.._classList.add('scroll-pt-1'); //
  TailwindClass get scrollPaddingTop2 => this.._classList.add('scroll-pt-2'); //
  TailwindClass get scrollPaddingTop4 => this.._classList.add('scroll-pt-4'); //
  TailwindClass get scrollPaddingTop8 => this.._classList.add('scroll-pt-8'); //

  ///========================= scroll-snap =========================///
  TailwindClass get snapNone => this.._classList.add('snap-none'); //
  TailwindClass get snapX => this.._classList.add('snap-x'); //
  TailwindClass get snapY => this.._classList.add('snap-y'); //
  TailwindClass get snapBoth => this.._classList.add('snap-both'); //
  TailwindClass get snapMandatory => this.._classList.add('snap-mandatory'); //
  TailwindClass get snapProximity => this.._classList.add('snap-proximity'); //
  TailwindClass get snapStart => this.._classList.add('snap-start'); //
  TailwindClass get snapEnd => this.._classList.add('snap-end'); //
  TailwindClass get snapCenter => this.._classList.add('snap-center'); //
  TailwindClass get snapAlignNone => this.._classList.add('snap-align-none'); //
  TailwindClass get snapNormal => this.._classList.add('snap-normal'); //
  TailwindClass get snapAlways => this.._classList.add('snap-always'); //

  ///========================= touch-action =========================///
  TailwindClass get touchAuto => this.._classList.add('touch-auto'); //
  TailwindClass get touchNone => this.._classList.add('touch-none'); //
  TailwindClass get touchPanX => this.._classList.add('touch-pan-x'); //
  TailwindClass get touchPanLeft => this.._classList.add('touch-pan-left'); //
  TailwindClass get touchPanRight => this.._classList.add('touch-pan-right'); //
  TailwindClass get touchPanY => this.._classList.add('touch-pan-y'); //
  TailwindClass get touchPanUp => this.._classList.add('touch-pan-up'); //
  TailwindClass get touchPanDown => this.._classList.add('touch-pan-down'); //
  TailwindClass get touchPinchZoom =>
      this.._classList.add('touch-pinch-zoom'); //
  TailwindClass get touchManipulation =>
      this.._classList.add('touch-manipulation'); //

  ///========================= will-change =========================///
  TailwindClass get willChangeAuto =>
      this.._classList.add('will-change-auto'); //
  TailwindClass get willChangeScroll =>
      this.._classList.add('will-change-scroll'); //
  TailwindClass get willChangeContents =>
      this.._classList.add('will-change-contents'); //
  TailwindClass get willChangeTransform =>
      this.._classList.add('will-change-transform'); //

  ///========================= Filters =========================///
  TailwindClass get blur0 => this.._classList.add('blur-0'); //
  TailwindClass get blurSm => this.._classList.add('blur-sm'); //
  TailwindClass get blur => this.._classList.add('blur'); //
  TailwindClass get blurMd => this.._classList.add('blur-md'); //
  TailwindClass get blurLg => this.._classList.add('blur-lg'); //
  TailwindClass get blurXl => this.._classList.add('blur-xl'); //
  TailwindClass get blur2xl => this.._classList.add('blur-2xl'); //
  TailwindClass get blur3xl => this.._classList.add('blur-3xl'); //

  TailwindClass get brightness0 => this.._classList.add('brightness-0'); //
  TailwindClass get brightness50 => this.._classList.add('brightness-50'); //
  TailwindClass get brightness75 => this.._classList.add('brightness-75'); //
  TailwindClass get brightness90 => this.._classList.add('brightness-90'); //
  TailwindClass get brightness95 => this.._classList.add('brightness-95'); //
  TailwindClass get brightness100 => this.._classList.add('brightness-100'); //
  TailwindClass get brightness105 => this.._classList.add('brightness-105'); //
  TailwindClass get brightness110 => this.._classList.add('brightness-110'); //
  TailwindClass get brightness125 => this.._classList.add('brightness-125'); //
  TailwindClass get brightness150 => this.._classList.add('brightness-150'); //
  TailwindClass get brightness200 => this.._classList.add('brightness-200'); //

  TailwindClass get contrast0 => this.._classList.add('contrast-0'); //
  TailwindClass get contrast50 => this.._classList.add('contrast-50'); //
  TailwindClass get contrast75 => this.._classList.add('contrast-75'); //
  TailwindClass get contrast100 => this.._classList.add('contrast-100'); //
  TailwindClass get contrast125 => this.._classList.add('contrast-125'); //
  TailwindClass get contrast150 => this.._classList.add('contrast-150'); //
  TailwindClass get contrast200 => this.._classList.add('contrast-200'); //

  TailwindClass get grayscale0 => this.._classList.add('grayscale-0'); //
  TailwindClass get grayscale => this.._classList.add('grayscale'); //

  TailwindClass get hueRotate0 => this.._classList.add('hue-rotate-0'); //
  TailwindClass get hueRotate15 => this.._classList.add('hue-rotate-15'); //
  TailwindClass get hueRotate30 => this.._classList.add('hue-rotate-30'); //
  TailwindClass get hueRotate60 => this.._classList.add('hue-rotate-60'); //
  TailwindClass get hueRotate90 => this.._classList.add('hue-rotate-90'); //
  TailwindClass get hueRotate180 => this.._classList.add('hue-rotate-180'); //

  TailwindClass get invert0 => this.._classList.add('invert-0'); //
  TailwindClass get invert => this.._classList.add('invert'); //

  TailwindClass get saturate0 => this.._classList.add('saturate-0'); //
  TailwindClass get saturate50 => this.._classList.add('saturate-50'); //
  TailwindClass get saturate100 => this.._classList.add('saturate-100'); //
  TailwindClass get saturate150 => this.._classList.add('saturate-150'); //
  TailwindClass get saturate200 => this.._classList.add('saturate-200'); //

  TailwindClass get sepia0 => this.._classList.add('sepia-0'); //
  TailwindClass get sepia => this.._classList.add('sepia'); //

  TailwindClass get dropShadowSm => this.._classList.add('drop-shadow-sm'); //
  TailwindClass get dropShadow => this.._classList.add('drop-shadow'); //
  TailwindClass get dropShadowMd => this.._classList.add('drop-shadow-md'); //
  TailwindClass get dropShadowLg => this.._classList.add('drop-shadow-lg'); //
  TailwindClass get dropShadowXl => this.._classList.add('drop-shadow-xl'); //
  TailwindClass get dropShadow2xl => this.._classList.add('drop-shadow-2xl'); //
  TailwindClass get dropShadowNone =>
      this.._classList.add('drop-shadow-none'); //

  ///========================= Backdrop Filters =========================///
  TailwindClass get backdropBlur0 => this.._classList.add('backdrop-blur-0'); //
  TailwindClass get backdropBlurSm =>
      this.._classList.add('backdrop-blur-sm'); //
  TailwindClass get backdropBlur => this.._classList.add('backdrop-blur'); //
  TailwindClass get backdropBlurMd =>
      this.._classList.add('backdrop-blur-md'); //
  TailwindClass get backdropBlurLg =>
      this.._classList.add('backdrop-blur-lg'); //
  TailwindClass get backdropBlurXl =>
      this.._classList.add('backdrop-blur-xl'); //
  TailwindClass get backdropBlur2xl =>
      this.._classList.add('backdrop-blur-2xl'); //
  TailwindClass get backdropBlur3xl =>
      this.._classList.add('backdrop-blur-3xl'); //

  TailwindClass get backdropBrightness0 =>
      this.._classList.add('backdrop-brightness-0'); //
  TailwindClass get backdropBrightness50 =>
      this.._classList.add('backdrop-brightness-50'); //
  TailwindClass get backdropBrightness75 =>
      this.._classList.add('backdrop-brightness-75'); //
  TailwindClass get backdropBrightness90 =>
      this.._classList.add('backdrop-brightness-90'); //
  TailwindClass get backdropBrightness95 =>
      this.._classList.add('backdrop-brightness-95'); //
  TailwindClass get backdropBrightness100 =>
      this.._classList.add('backdrop-brightness-100'); //
  TailwindClass get backdropBrightness105 =>
      this.._classList.add('backdrop-brightness-105'); //
  TailwindClass get backdropBrightness110 =>
      this.._classList.add('backdrop-brightness-110'); //
  TailwindClass get backdropBrightness125 =>
      this.._classList.add('backdrop-brightness-125'); //
  TailwindClass get backdropBrightness150 =>
      this.._classList.add('backdrop-brightness-150'); //
  TailwindClass get backdropBrightness200 =>
      this.._classList.add('backdrop-brightness-200'); //

  TailwindClass get backdropContrast0 =>
      this.._classList.add('backdrop-contrast-0'); //
  TailwindClass get backdropContrast50 =>
      this.._classList.add('backdrop-contrast-50'); //
  TailwindClass get backdropContrast75 =>
      this.._classList.add('backdrop-contrast-75'); //
  TailwindClass get backdropContrast100 =>
      this.._classList.add('backdrop-contrast-100'); //
  TailwindClass get backdropContrast125 =>
      this.._classList.add('backdrop-contrast-125'); //
  TailwindClass get backdropContrast150 =>
      this.._classList.add('backdrop-contrast-150'); //
  TailwindClass get backdropContrast200 =>
      this.._classList.add('backdrop-contrast-200'); //

  TailwindClass get backdropGrayscale0 =>
      this.._classList.add('backdrop-grayscale-0'); //
  TailwindClass get backdropGrayscale =>
      this.._classList.add('backdrop-grayscale'); //

  TailwindClass get backdropHueRotate0 =>
      this.._classList.add('backdrop-hue-rotate-0'); //
  TailwindClass get backdropHueRotate15 =>
      this.._classList.add('backdrop-hue-rotate-15'); //
  TailwindClass get backdropHueRotate30 =>
      this.._classList.add('backdrop-hue-rotate-30'); //
  TailwindClass get backdropHueRotate60 =>
      this.._classList.add('backdrop-hue-rotate-60'); //
  TailwindClass get backdropHueRotate90 =>
      this.._classList.add('backdrop-hue-rotate-90'); //
  TailwindClass get backdropHueRotate180 =>
      this.._classList.add('backdrop-hue-rotate-180'); //

  TailwindClass get backdropInvert0 =>
      this.._classList.add('backdrop-invert-0'); //
  TailwindClass get backdropInvert =>
      this.._classList.add('backdrop-invert'); //

  TailwindClass get backdropOpacity0 =>
      this.._classList.add('backdrop-opacity-0'); //
  TailwindClass get backdropOpacity5 =>
      this.._classList.add('backdrop-opacity-5'); //
  TailwindClass get backdropOpacity10 =>
      this.._classList.add('backdrop-opacity-10'); //
  TailwindClass get backdropOpacity20 =>
      this.._classList.add('backdrop-opacity-20'); //
  TailwindClass get backdropOpacity25 =>
      this.._classList.add('backdrop-opacity-25'); //
  TailwindClass get backdropOpacity30 =>
      this.._classList.add('backdrop-opacity-30'); //
  TailwindClass get backdropOpacity40 =>
      this.._classList.add('backdrop-opacity-40'); //
  TailwindClass get backdropOpacity50 =>
      this.._classList.add('backdrop-opacity-50'); //
  TailwindClass get backdropOpacity60 =>
      this.._classList.add('backdrop-opacity-60'); //
  TailwindClass get backdropOpacity70 =>
      this.._classList.add('backdrop-opacity-70'); //
  TailwindClass get backdropOpacity75 =>
      this.._classList.add('backdrop-opacity-75'); //
  TailwindClass get backdropOpacity80 =>
      this.._classList.add('backdrop-opacity-80'); //
  TailwindClass get backdropOpacity90 =>
      this.._classList.add('backdrop-opacity-90'); //
  TailwindClass get backdropOpacity95 =>
      this.._classList.add('backdrop-opacity-95'); //
  TailwindClass get backdropOpacity100 =>
      this.._classList.add('backdrop-opacity-100'); //

  TailwindClass get backdropSaturate0 =>
      this.._classList.add('backdrop-saturate-0'); //
  TailwindClass get backdropSaturate50 =>
      this.._classList.add('backdrop-saturate-50'); //
  TailwindClass get backdropSaturate100 =>
      this.._classList.add('backdrop-saturate-100'); //
  TailwindClass get backdropSaturate150 =>
      this.._classList.add('backdrop-saturate-150'); //
  TailwindClass get backdropSaturate200 =>
      this.._classList.add('backdrop-saturate-200'); //

  TailwindClass get backdropSepia0 =>
      this.._classList.add('backdrop-sepia-0'); //
  TailwindClass get backdropSepia => this.._classList.add('backdrop-sepia'); //

  ///========================= Tables =========================///
  TailwindClass get borderCollapse =>
      this.._classList.add('border-collapse'); //
  TailwindClass get borderSeparate =>
      this.._classList.add('border-separate'); //
  TailwindClass get borderSpacing0 =>
      this.._classList.add('border-spacing-0'); //
  TailwindClass get borderSpacing1 =>
      this.._classList.add('border-spacing-1'); //
  TailwindClass get borderSpacing2 =>
      this.._classList.add('border-spacing-2'); //
  TailwindClass get borderSpacing4 =>
      this.._classList.add('border-spacing-4'); //
  TailwindClass get borderSpacing8 =>
      this.._classList.add('border-spacing-8'); //
  TailwindClass get borderSpacingX0 =>
      this.._classList.add('border-spacing-x-0'); //
  TailwindClass get borderSpacingX1 =>
      this.._classList.add('border-spacing-x-1'); //
  TailwindClass get borderSpacingX2 =>
      this.._classList.add('border-spacing-x-2'); //
  TailwindClass get borderSpacingX4 =>
      this.._classList.add('border-spacing-x-4'); //
  TailwindClass get borderSpacingX8 =>
      this.._classList.add('border-spacing-x-8'); //
  TailwindClass get borderSpacingY0 =>
      this.._classList.add('border-spacing-y-0'); //
  TailwindClass get borderSpacingY1 =>
      this.._classList.add('border-spacing-y-1'); //
  TailwindClass get borderSpacingY2 =>
      this.._classList.add('border-spacing-y-2'); //
  TailwindClass get borderSpacingY4 =>
      this.._classList.add('border-spacing-y-4'); //
  TailwindClass get borderSpacingY8 =>
      this.._classList.add('border-spacing-y-8'); //
  TailwindClass get tableAuto => this.._classList.add('table-auto'); //
  TailwindClass get tableFixed => this.._classList.add('table-fixed'); //
  TailwindClass get captionTop => this.._classList.add('caption-top'); //
  TailwindClass get captionBottom => this.._classList.add('caption-bottom'); //

  ///========================= Transforms =========================///
  TailwindClass get transformGpu => this.._classList.add('transform-gpu'); //
  TailwindClass get transformNone => this.._classList.add('transform-none'); //

  TailwindClass get scale0 => this.._classList.add('scale-0'); //
  TailwindClass get scale50 => this.._classList.add('scale-50'); //
  TailwindClass get scale75 => this.._classList.add('scale-75'); //
  TailwindClass get scale90 => this.._classList.add('scale-90'); //
  TailwindClass get scale95 => this.._classList.add('scale-95'); //
  TailwindClass get scale100 => this.._classList.add('scale-100'); //
  TailwindClass get scale105 => this.._classList.add('scale-105'); //
  TailwindClass get scale110 => this.._classList.add('scale-110'); //
  TailwindClass get scale125 => this.._classList.add('scale-125'); //
  TailwindClass get scale150 => this.._classList.add('scale-150'); //

  TailwindClass get scaleX0 => this.._classList.add('scale-x-0'); //
  TailwindClass get scaleX50 => this.._classList.add('scale-x-50'); //
  TailwindClass get scaleX75 => this.._classList.add('scale-x-75'); //
  TailwindClass get scaleX90 => this.._classList.add('scale-x-90'); //
  TailwindClass get scaleX95 => this.._classList.add('scale-x-95'); //
  TailwindClass get scaleX100 => this.._classList.add('scale-x-100'); //
  TailwindClass get scaleX105 => this.._classList.add('scale-x-105'); //
  TailwindClass get scaleX110 => this.._classList.add('scale-x-110'); //
  TailwindClass get scaleX125 => this.._classList.add('scale-x-125'); //
  TailwindClass get scaleX150 => this.._classList.add('scale-x-150'); //

  TailwindClass get scaleY0 => this.._classList.add('scale-y-0'); //
  TailwindClass get scaleY50 => this.._classList.add('scale-y-50'); //
  TailwindClass get scaleY75 => this.._classList.add('scale-y-75'); //
  TailwindClass get scaleY90 => this.._classList.add('scale-y-90'); //
  TailwindClass get scaleY95 => this.._classList.add('scale-y-95'); //
  TailwindClass get scaleY100 => this.._classList.add('scale-y-100'); //
  TailwindClass get scaleY105 => this.._classList.add('scale-y-105'); //
  TailwindClass get scaleY110 => this.._classList.add('scale-y-110'); //
  TailwindClass get scaleY125 => this.._classList.add('scale-y-125'); //
  TailwindClass get scaleY150 => this.._classList.add('scale-y-150'); //

  TailwindClass get rotate0 => this.._classList.add('rotate-0'); //
  TailwindClass get rotate1 => this.._classList.add('rotate-1'); //
  TailwindClass get rotate2 => this.._classList.add('rotate-2'); //
  TailwindClass get rotate3 => this.._classList.add('rotate-3'); //
  TailwindClass get rotate6 => this.._classList.add('rotate-6'); //
  TailwindClass get rotate12 => this.._classList.add('rotate-12'); //
  TailwindClass get rotate45 => this.._classList.add('rotate-45'); //
  TailwindClass get rotate90 => this.._classList.add('rotate-90'); //
  TailwindClass get rotate180 => this.._classList.add('rotate-180'); //

  TailwindClass get translateX0 => this.._classList.add('translate-x-0'); //
  TailwindClass get translateX1 => this.._classList.add('translate-x-1'); //
  TailwindClass get translateX2 => this.._classList.add('translate-x-2'); //
  TailwindClass get translateX4 => this.._classList.add('translate-x-4'); //
  TailwindClass get translateX8 => this.._classList.add('translate-x-8'); //
  TailwindClass get translateX12 => this.._classList.add('translate-x-12'); //
  TailwindClass get translateX16 => this.._classList.add('translate-x-16'); //
  TailwindClass get translateX20 => this.._classList.add('translate-x-20'); //
  TailwindClass get translateX24 => this.._classList.add('translate-x-24'); //
  TailwindClass get translateX32 => this.._classList.add('translate-x-32'); //
  TailwindClass get translateX40 => this.._classList.add('translate-x-40'); //
  TailwindClass get translateX48 => this.._classList.add('translate-x-48'); //
  TailwindClass get translateX56 => this.._classList.add('translate-x-56'); //
  TailwindClass get translateX64 => this.._classList.add('translate-x-64'); //
  TailwindClass get translateXFull =>
      this.._classList.add('translate-x-full'); //

  TailwindClass get translateY0 => this.._classList.add('translate-y-0'); //
  TailwindClass get translateY1 => this.._classList.add('translate-y-1'); //
  TailwindClass get translateY2 => this.._classList.add('translate-y-2'); //
  TailwindClass get translateY4 => this.._classList.add('translate-y-4'); //
  TailwindClass get translateY8 => this.._classList.add('translate-y-8'); //
  TailwindClass get translateY12 => this.._classList.add('translate-y-12'); //
  TailwindClass get translateY16 => this.._classList.add('translate-y-16'); //
  TailwindClass get translateY20 => this.._classList.add('translate-y-20'); //
  TailwindClass get translateY24 => this.._classList.add('translate-y-24'); //
  TailwindClass get translateY32 => this.._classList.add('translate-y-32'); //
  TailwindClass get translateY40 => this.._classList.add('translate-y-40'); //
  TailwindClass get translateY48 => this.._classList.add('translate-y-48'); //
  TailwindClass get translateY56 => this.._classList.add('translate-y-56'); //
  TailwindClass get translateY64 => this.._classList.add('translate-y-64'); //
  TailwindClass get translateYFull =>
      this.._classList.add('translate-y-full'); //

  TailwindClass get skewX0 => this.._classList.add('skew-x-0'); //
  TailwindClass get skewX1 => this.._classList.add('skew-x-1'); //
  TailwindClass get skewX2 => this.._classList.add('skew-x-2'); //
  TailwindClass get skewX3 => this.._classList.add('skew-x-3'); //
  TailwindClass get skewX6 => this.._classList.add('skew-x-6'); //
  TailwindClass get skewX12 => this.._classList.add('skew-x-12'); //

  TailwindClass get skewY0 => this.._classList.add('skew-y-0'); //
  TailwindClass get skewY1 => this.._classList.add('skew-y-1'); //
  TailwindClass get skewY2 => this.._classList.add('skew-y-2'); //
  TailwindClass get skewY3 => this.._classList.add('skew-y-3'); //
  TailwindClass get skewY6 => this.._classList.add('skew-y-6'); //
  TailwindClass get skewY12 => this.._classList.add('skew-y-12'); //

  ///========================= SVG =========================///
  TailwindClass get fillCurrent => this.._classList.add('fill-current'); //
  TailwindClass get fillNone => this.._classList.add('fill-none'); //

  TailwindClass get strokeCurrent => this.._classList.add('stroke-current'); //
  TailwindClass get strokeNone => this.._classList.add('stroke-none'); //
  TailwindClass get stroke0 => this.._classList.add('stroke-0'); //
  TailwindClass get stroke1 => this.._classList.add('stroke-1'); //
  TailwindClass get stroke2 => this.._classList.add('stroke-2'); //

  ///========================= Accessibility =========================///
  TailwindClass get srOnly => this.._classList.add('sr-only'); //
  TailwindClass get notSrOnly => this.._classList.add('not-sr-only'); //
  TailwindClass get forcedColorAdjustAuto =>
      this.._classList.add('forced-color-adjust-auto'); //
  TailwindClass get forcedColorAdjustNone =>
      this.._classList.add('forced-color-adjust-none'); //

  String build() => '${initialClass ?? ''} ${_classList.join(' ')}'.trim();
}
