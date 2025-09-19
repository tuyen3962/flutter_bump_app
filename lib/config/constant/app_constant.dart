const DAY_FORMAT = 'dd/MM/yyyy';
const DAY_MONTH_FORMAT = 'dd/MM';
const HOUR_FORMAT = 'HH:mm';

const LIMIT = 20;

RegExp spaceRegExp = RegExp(' +');

enum PreSignUrlType { image, video, raw }

enum Provider { GOOGLE, YOUTUBE, TIKTOK }

enum UserGender { MALE, FEMALE, OTHER }

enum AIProvider { GROK, CLAUDE, OPENAI, GEMINI }

enum VideoUploadStatus { PENDING, UPLOADING, COMPLETED, FAILED }

enum VideoFormat { MP4, AVI, MOV, MKV, FLV, WMV, WEBM, MPEG, OTHER }

enum MemoriesStatus { UNPARSE, PARSE, FAIL }

enum ProcessingStatus { PENDING, PROCESSING, COMPLETED, FAILED }

enum YouTubeUploadStatus {
  PENDING,
  UPLOADING,
  PROCESSING,
  PUBLISHED,
  FAILED,
  SCHEDULED
}

enum YouTubePrivacy { PUBLIC, UNLISTED, PRIVATE }
