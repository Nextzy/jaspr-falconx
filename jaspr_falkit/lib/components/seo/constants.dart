import 'package:jaspr_falkit/lib.dart';

@JsonEnum(valueField: 'name')
enum OgType {
  website('website'),
  article('article'),
  book('book'),
  profile('profile'),
  videoMovie('video.movie'),
  videoEpisode('video.episode'),
  videoTvShow('video.tv_show'),
  videoOther('video.other'),
  musicSong('music.song'),
  musicAlbum('music.album'),
  musicPlaylist('music.playlist'),
  musicRadioStation('music.radio_station'),
  business('business.business'),
  place('place'),
  product('product'),
  restaurant('restaurant'),
  fitnessCourse('fitness.course');

  const OgType(this.name);

  final String name;

  @decoder
  static OgType fromJson(String json) => OgType.values.firstWhere(
    (data) => data.name == json,
    orElse: () => OgType.website,
  );

  @encoder
  String toJson() => name;
}
