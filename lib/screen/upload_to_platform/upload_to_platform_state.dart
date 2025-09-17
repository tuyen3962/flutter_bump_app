import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum Platform { youtube, tiktok }

enum Visibilitys { public, unlisted, private }

class UploadToPlatformState extends BaseState {
  final Platform platform;
  final String title;
  final String description;
  final Visibilitys visibility;
  final String category;
  final String tags;
  final bool isUploading;
  final double uploadProgress;

  const UploadToPlatformState({
    this.platform = Platform.youtube,
    this.title = 'Amazing Basketball Highlights',
    this.description = 'Check out these incredible sports highlights! Amazing plays and unforgettable moments captured in this compilation.',
    this.visibility = Visibilitys.public,
    this.category = 'Sports',
    this.tags = 'basketball, highlights, sports, game',
    this.isUploading = false,
    this.uploadProgress = 0.0,
  });

  UploadToPlatformState copyWith({
    Platform? platform,
    String? title,
    String? description,
    Visibilitys? visibility,
    String? category,
    String? tags,
    bool? isUploading,
    double? uploadProgress,
  }) {
    return UploadToPlatformState(
      platform: platform ?? this.platform,
      title: title ?? this.title,
      description: description ?? this.description,
      visibility: visibility ?? this.visibility,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isUploading: isUploading ?? this.isUploading,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }

  String get platformName => platform == Platform.youtube ? 'YouTube' : 'TikTok';

  int get titleMaxLength => platform == Platform.youtube ? 100 : 150;

  int get descriptionMaxLength => platform == Platform.youtube ? 5000 : 2200;

  bool get isFormValid {
    if (title.trim().isEmpty) return false;
    if (platform == Platform.youtube && category.trim().isEmpty) return false;
    return true;
  }

  String get visibilityText {
    switch (visibility) {
      case Visibilitys.public:
        return 'Public';
      case Visibilitys.unlisted:
        return 'Unlisted';
      case Visibilitys.private:
        return 'Private';
    }
  }

  bool get showYouTubeSpecificFields => platform == Platform.youtube;

  @override
  List<Object?> get props => [
        platform,
        title,
        description,
        visibility,
        category,
        tags,
        isUploading,
        uploadProgress,
      ];
}