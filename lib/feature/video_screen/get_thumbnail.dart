import 'package:video_thumbnail/video_thumbnail.dart';

Future<String> getThumbnail(String videoPath) async {
  String? thumb = await VideoThumbnail.thumbnailFile(video: videoPath);
  return thumb!;
}