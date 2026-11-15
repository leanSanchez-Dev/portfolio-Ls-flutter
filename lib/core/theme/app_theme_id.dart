/// Identifiers for portfolio IDE-style themes.
///
/// Persist via [storageKey]; resolve with [fromStorage] (default: [obsidian]).
enum AppThemeId {
  /// Dark ESD current (default).
  obsidian,
  light,
  monokai,
  panda;

  String get storageKey => name;

  /// Parses a persisted key; unknown / null → [obsidian].
  static AppThemeId fromStorage(String? raw) {
    if (raw == null || raw.isEmpty) return AppThemeId.obsidian;
    for (final id in AppThemeId.values) {
      if (id.storageKey == raw) return id;
    }
    return AppThemeId.obsidian;
  }

  /// Spanish UI label.
  String get labelEs => switch (this) {
        AppThemeId.obsidian => 'Obsidian',
        AppThemeId.light => 'Claro',
        AppThemeId.monokai => 'Monokai',
        AppThemeId.panda => 'Panda',
      };

  /// English UI label.
  String get labelEn => switch (this) {
        AppThemeId.obsidian => 'Obsidian',
        AppThemeId.light => 'Light',
        AppThemeId.monokai => 'Monokai',
        AppThemeId.panda => 'Panda',
      };

  /// Dark IDE themes (not light).
  bool get isDark => this != AppThemeId.light;

  /// Cycle order: obsidian → monokai → panda → light → obsidian.
  AppThemeId get next => switch (this) {
        AppThemeId.obsidian => AppThemeId.monokai,
        AppThemeId.monokai => AppThemeId.panda,
        AppThemeId.panda => AppThemeId.light,
        AppThemeId.light => AppThemeId.obsidian,
      };
}
