class EmojiWrapper {
  // Comprehensive emoji detection pattern
  static final RegExp emojiPattern = RegExp(
    '(?:'
    // Basic emoji ranges
    r'[\u{1F600}-\u{1F64F}]' // Emoticons
    r'|[\u{1F300}-\u{1F5FF}]' // Misc Symbols and Pictographs
    r'|[\u{1F680}-\u{1F6FF}]' // Transport and Map
    r'|[\u{1F1E0}-\u{1F1FF}]' // Regional country flags
    r'|[\u{2600}-\u{26FF}]' // Misc symbols
    r'|[\u{2700}-\u{27BF}]' // Dingbats
    r'|[\u{1F900}-\u{1F9FF}]' // Supplemental Symbols and Pictographs
    r'|[\u{1FA70}-\u{1FAFF}]' // Symbols and Pictographs Extended-A
    r'|[\u{1F700}-\u{1F77F}]' // Alchemical Symbols
    r'|[\u{1F780}-\u{1F7FF}]' // Geometric Shapes Extended
    r'|[\u{1F800}-\u{1F8FF}]' // Supplemental Arrows-C
    r'|[\u{2B50}]' // Star
    r'|[\u{2B55}]' // Circle
    r'|[\u{231A}-\u{231B}]' // Watch, hourglass
    r'|[\u{2328}]' // Keyboard
    r'|[\u{23CF}]' // Eject symbol
    r'|[\u{23E9}-\u{23F3}]' // Media symbols
    r'|[\u{23F8}-\u{23FA}]' // Media symbols
    r'|[\u{24C2}]' // Circled M
    r'|[\u{25AA}-\u{25AB}]' // Squares
    r'|[\u{25B6}]' // Play button
    r'|[\u{25C0}]' // Reverse play
    r'|[\u{25FB}-\u{25FE}]' // Squares
    r'|[\u{2934}-\u{2935}]' // Arrows
    r'|[\u{2B05}-\u{2B07}]' // Arrows
    r'|[\u{2B1B}-\u{2B1C}]' // Squares
    r'|[\u{3030}]' // Wavy dash
    r'|[\u{303D}]' // Part alternation mark
    r'|[\u{3297}]' // Circled ideograph congratulation
    r'|[\u{3299}]' // Circled ideograph secret
    r'|[\u{00A9}]' // Copyright
    r'|[\u{00AE}]' // Registered
    r'|[\u{2122}]' // Trademark
    r'|[\u{2139}]' // Information
    r'|[\u{2194}-\u{2199}]' // Arrows
    r'|[\u{21A9}-\u{21AA}]' // Arrows
    r'|[\u{2300}-\u{23FF}]' // Miscellaneous Technical
    r'|[\u{2460}-\u{24FF}]' // Enclosed Alphanumerics
    r'|[\u{25A0}-\u{25FF}]' // Geometric Shapes
    r'|[\u{2600}-\u{27BF}]' // Miscellaneous Symbols and Dingbats
    r'|[\u{2900}-\u{297F}]' // Supplemental Arrows-B
    r'|[\u{2B00}-\u{2BFF}]' // Miscellaneous Symbols and Arrows
    r'|[\u{1F000}-\u{1F02F}]' // Mahjong tiles
    r'|[\u{1F030}-\u{1F09F}]' // Domino tiles
    r'|[\u{1F0A0}-\u{1F0FF}]' // Playing cards
    ')'
    // Optional variation selectors
    r'(?:\uFE0F)?'
    // Optional skin tone modifiers
    r'(?:[\u{1F3FB}-\u{1F3FF}])?'
    // Optional ZWJ sequences
    '(?:'
    r'\u200D' // Zero Width Joiner
    '(?:'
    r'[\u{1F300}-\u{1F9FF}]' // Another emoji
    r'(?:\uFE0F)?' // Optional variation selector
    r'(?:[\u{1F3FB}-\u{1F3FF}])?' // Optional skin tone
    ')*'
    ')?'
    // Country flag sequences
    r'|(?:[\u{1F1E6}-\u{1F1FF}]){2}'
    // Keycap sequences
    r'|[0-9*#]\uFE0F?\u20E3',
    unicode: true,
    multiLine: true,
  );

  static String wrapEmojis(
    String? text, {
    String className = 'text-black',
    String tag = 'span',
  }) {
    if (text == null || text.isEmpty) return '';
    if (!_mightContainEmoji(text)) return text;

    // Skip the pre-check to ensure all emojis are detected
    return text.replaceAllMapped(
      emojiPattern,
      (match) => '<$tag class="$className">${match.group(0)}</$tag>',
    );
  }

  // Quick pre-check to avoid regex on text that definitely has no emojis
  static bool _mightContainEmoji(String text) {
    // Check for any non-ASCII characters as a quick filter
    for (var i = 0; i < text.length; i++) {
      final code = text.codeUnitAt(i);
      // Any character above basic ASCII might be an emoji
      if (code > 127) {
        return true;
      }
    }
    return false;
  }
}
