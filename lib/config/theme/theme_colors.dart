// import 'dart:ui';

// import 'palettes.dart';

// class ThemeColors extends BaseThemeColors<NormalPalettes> {
//   @override
//   final NormalPalettes palettes = NormalPalettes();
// }

// abstract class BaseThemeColors<T extends BasePalettes> {
//   T get palettes;

//   BackgroundColors get background => BackgroundColors(palettes);

//   TextColors get text => TextColors(palettes);

//   LinkColors get link => LinkColors(palettes);

//   BorderColors get border => BorderColors(palettes);

//   BorderBrandColors get borderBrand => BorderBrandColors(palettes);

//   IconColors get icon => IconColors(palettes);

//   ComponentColors get component => ComponentColors(palettes);
// }

// class _Colors<T extends BasePalettes> {
//   _Colors(this.palettes);
//   final T palettes;
// }

// class ComponentColors<T extends BasePalettes> extends _Colors<T> {
//   ComponentColors(super.palettes);

//   RatingColors get rating => RatingColors(palettes);
//   ButtonColors get button => ButtonColors(palettes);
// }

// class ButtonColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonColors(super.palettes);

//   ButtonPrimaryColors get primary => ButtonPrimaryColors(palettes);
//   ButtonSecondaryColors get secondary => ButtonSecondaryColors(palettes);
//   ButtonGhostColors get ghost => ButtonGhostColors(palettes);
//   ButtonDangerSolidColors get dangerSolid => ButtonDangerSolidColors(palettes);
//   ButtonTertiaryColors get tertiary => ButtonTertiaryColors(palettes);
//   ButtonAlphaColors get alpha => ButtonAlphaColors(palettes);
//   ButtonDangerLightColors get dangerLight => ButtonDangerLightColors(palettes);
// }

// class BackgroundColors<T extends BasePalettes> extends _Colors<T> {
//   BackgroundColors(super.palettes);

//   Color get primary => palettes.neutral000;
//   Color get primaryHovered => palettes.neutral200;
//   Color get secondary => palettes.neutral100;
//   Color get tertiary => palettes.neutral300;
//   Color get disable => palettes.neutral200;
//   Color get inactive => palettes.neutral100;
//   Color get solid => palettes.neutral700;
//   Color get error => palettes.danger300;
//   Color get dangerSubtle => palettes.danger100;
//   Color get warning => palettes.warning300;
//   Color get warningSubtle => palettes.warning100;
//   Color get success => palettes.success300;
//   Color get successSubtle => palettes.success100;
//   Color get info => palettes.info300;
//   Color get infoSubtle => palettes.info100;

//   BackgroundBrandColors get brand => BackgroundBrandColors(palettes);
//   BackgroundTransparentColors get transparent =>
//       BackgroundTransparentColors(palettes);
// }

// class BackgroundBrandColors<T extends BasePalettes> extends _Colors<T> {
//   BackgroundBrandColors(super.palettes);
//   Color get primary => palettes.primary400;
//   Color get primaryHovered => palettes.primary300;
//   Color get primaryMedium => palettes.primary300;
//   Color get primarySubtle => palettes.primary50;
//   Color get secondary => palettes.secondary400;
//   Color get secondaryHovered => palettes.secondary500;
//   Color get secondaryMedium => palettes.secondary300;
//   Color get brandSecondarySubtle => palettes.secondary50;
// }

// class BackgroundTransparentColors<T extends BasePalettes> extends _Colors<T> {
//   BackgroundTransparentColors(super.palettes);
//   Color get whiteXSmall => palettes.alphaWhite8;
//   Color get whiteSmall => palettes.alphaWhite16;
//   Color get whiteMedium => palettes.alphaWhite48;
//   Color get whiteLarge => palettes.alphaWhite80;

//   Color get blackXSmall => palettes.alphaBlack8;
//   Color get blackSmall => palettes.alphaBlack16;
//   Color get blackMedium => palettes.alphaBlack48;
//   Color get blackLarge => palettes.alphaBlack80;
// }

// class TextColors<T extends BasePalettes> extends _Colors<T> {
//   TextColors(super.palettes);

//   Color get primary => palettes.neutral700;
//   Color get primaryInverse => palettes.neutral000;
//   Color get secondary => palettes.neutral600;
//   Color get secondaryInverse => palettes.neutral200;
//   Color get tertiary => palettes.neutral500;
//   Color get inactive => palettes.neutral500;
//   Color get disable => palettes.neutral400;
//   Color get placeholder => palettes.neutral500;
//   Color get danger => palettes.danger300;
//   Color get dangerSubtle => palettes.danger400;
//   Color get warning => palettes.warning300;
//   Color get success => palettes.success300;
//   Color get info => palettes.info300;

//   TextBrandColors get brand => TextBrandColors(palettes);
// }

// class TextBrandColors<T extends BasePalettes> extends _Colors<T> {
//   TextBrandColors(super.palettes);

//   Color get primary => palettes.primary400;
//   Color get primarySub => palettes.primary300;
//   Color get secondary => palettes.secondary400;
//   Color get secondarySub => palettes.secondary300;
// }

// class LinkColors<T extends BasePalettes> extends _Colors<T> {
//   LinkColors(super.palettes);

//   Color get defaultColor => palettes.primary400;
//   Color get pressed => palettes.primary500;
//   Color get visited => palettes.primary500;
// }

// class BorderColors<T extends BasePalettes> extends _Colors<T> {
//   BorderColors(super.palettes);
//   Color get inverse => palettes.neutral000;
//   Color get primary => palettes.neutral100;
//   Color get secondary => palettes.neutral200;
//   Color get tertiary => palettes.neutral300;
//   Color get inactive => palettes.neutral500;
//   Color get strong => palettes.neutral700;
//   Color get danger => palettes.danger300;
//   Color get errorHovered => palettes.danger400;
//   Color get success => palettes.success300;
//   Color get successHovered => palettes.success400;
//   Color get warning => palettes.warning300;
//   Color get info => palettes.info300;
// }

// class BorderBrandColors<T extends BasePalettes> extends _Colors<T> {
//   BorderBrandColors(super.palettes);
//   Color get primary => palettes.primary400;
//   Color get primaryHover => palettes.primary500;
//   Color get secondary => palettes.secondary400;
// }

// class IconColors<T extends BasePalettes> extends _Colors<T> {
//   IconColors(super.palettes);
//   Color get inverse => palettes.neutral000;
//   Color get primary => palettes.neutral600;
//   Color get secondary => palettes.neutral500;
//   Color get inactive => palettes.neutral500;
//   Color get strong => palettes.neutral700;
//   Color get disabled => palettes.neutral400;
//   Color get brandPrimary => palettes.primary400;
//   Color get brandSecondary => palettes.secondary400;
//   Color get brandSecondarySub => palettes.secondary300;
//   Color get brandSub => palettes.primary500;
//   Color get danger => palettes.danger300;
//   Color get dangerSubtle => palettes.danger400;
//   Color get warning => palettes.warning300;
//   Color get success => palettes.success300;
//   Color get info => palettes.info300;
// }

// class ButtonPrimaryColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonPrimaryColors(super.palettes);

//   Color get fgDefault => palettes.neutral000;
//   Color get bgDefault => palettes.primary400;
//   Color get bgHovered => palettes.primary500;
// }

// class ButtonSecondaryColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonSecondaryColors(super.palettes);
//   Color get fgDefault => palettes.neutral700;
//   Color get bgDefault => palettes.neutral100;
//   Color get bgHovered => palettes.neutral200;
// }

// class ButtonGhostColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonGhostColors(super.palettes);

//   Color get fgDefault => palettes.neutral700;
// }

// class ButtonDangerSolidColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonDangerSolidColors(super.palettes);

//   Color get fgDefault => palettes.neutral000;
//   Color get bgDefault => palettes.danger300;
//   Color get bgHovered => palettes.danger400;
// }

// class ButtonTertiaryColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonTertiaryColors(super.palettes);

//   Color get fgDefault => palettes.neutral000;
//   Color get bgDefault => palettes.secondary400;
//   Color get bgHovered => palettes.secondary400;
// }

// class ButtonAlphaColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonAlphaColors(super.palettes);

//   Color get fgDefault => palettes.neutral000;
//   Color get bgDefault => palettes.alphaWhite16;
//   Color get bgHovered => palettes.alphaWhite32;
//   Color get bgPressed => palettes.alphaWhite48;
// }

// class ButtonDangerLightColors<T extends BasePalettes> extends _Colors<T> {
//   ButtonDangerLightColors(super.palettes);

//   Color get fgDefault => palettes.danger300;
//   Color get bgDefault => palettes.neutral100;
//   Color get bgHovered => palettes.neutral200;
// }

// class RatingColors<T extends BasePalettes> {
//   RatingColors(this.palettes);
//   final T palettes;

//   Color get foreground => palettes.rating;
// }
