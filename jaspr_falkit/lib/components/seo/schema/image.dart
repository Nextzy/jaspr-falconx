import 'package:jaspr_falkit/lib.dart';

/// ImageObject schema for representing images
class ImageSchema extends Schema {
  ImageSchema({
    required this.url,
    this.caption,
    this.width,
    this.height,
    this.name,
    this.description,
    this.contentUrl,
    this.contentSize,
    this.encodingFormat,
    this.uploadDate,
    this.embedUrl,
    this.thumbnail,
    this.representativeOfPage,
    this.exifData,
    this.author,
    this.creator,
    this.copyrightHolder,
    this.copyrightYear,
    this.datePublished,
    this.dateModified,
    this.license,
    this.acquireLicensePage,
    this.creditText,
    this.alternateName,
    this.inLanguage,
    this.keywords,
    this.additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'ImageObject',
           'url': url,
           if (caption != null) 'caption': caption,
           if (width != null) 'width': width,
           if (height != null) 'height': height,
           if (name != null) 'name': name,
           if (description != null) 'description': description,
           if (contentUrl != null) 'contentUrl': contentUrl,
           if (contentSize != null) 'contentSize': contentSize,
           if (encodingFormat != null) 'encodingFormat': encodingFormat,
           if (uploadDate != null) 'uploadDate': uploadDate,
           if (embedUrl != null) 'embedUrl': embedUrl,
           if (thumbnail != null) 'thumbnail': thumbnail.value,
           if (representativeOfPage != null)
             'representativeOfPage': representativeOfPage,
           if (exifData != null) 'exifData': exifData,
           if (author != null) 'author': author.value,
           if (creator != null) 'creator': creator.value,
           if (copyrightHolder != null) 'copyrightHolder': copyrightHolder,
           if (copyrightYear != null) 'copyrightYear': copyrightYear,
           if (datePublished != null) 'datePublished': datePublished,
           if (dateModified != null) 'dateModified': dateModified,
           if (license != null) 'license': license,
           if (acquireLicensePage != null)
             'acquireLicensePage': acquireLicensePage,
           if (creditText != null) 'creditText': creditText,
           if (alternateName != null) 'alternateName': alternateName,
           if (inLanguage != null) 'inLanguage': inLanguage,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for basic image
  factory ImageSchema.basic({
    required String url,
    String? caption,
    int? width,
    int? height,
  }) {
    return ImageSchema(
      url: url,
      caption: caption,
      width: width,
      height: height,
    );
  }

  /// Factory constructor for photo with metadata
  factory ImageSchema.photo({
    required String url,
    required String name,
    String? caption,
    String? description,
    int? width,
    int? height,
    String? datePublished,
    SchemaDataType<PersonSchema>? author,
    Map<String, dynamic>? exifData,
    String? license,
  }) {
    return ImageSchema(
      url: url,
      name: name,
      caption: caption,
      description: description,
      width: width,
      height: height,
      datePublished: datePublished,
      author: author,
      exifData: exifData,
      license: license,
    );
  }

  /// Factory constructor for thumbnail image
  factory ImageSchema.thumbnail({
    required String url,
    int width = 150,
    int height = 150,
  }) {
    return ImageSchema(
      url: url,
      width: width,
      height: height,
    );
  }

  /// Factory constructor for hero/banner image
  factory ImageSchema.hero({
    required String url,
    required String name,
    String? caption,
    int? width,
    int? height,
    bool representativeOfPage = true,
  }) {
    return ImageSchema(
      url: url,
      name: name,
      caption: caption,
      width: width,
      height: height,
      representativeOfPage: representativeOfPage,
    );
  }

  final String url;
  final String? caption;
  final int? width;
  final int? height;
  final String? name;
  final String? description;
  final String? contentUrl;
  final String? contentSize;
  final String? encodingFormat;
  final String? uploadDate;
  final String? embedUrl;
  final SchemaDataType<ImageSchema>? thumbnail;
  final bool? representativeOfPage;
  final Map<String, dynamic>? exifData;
  final SchemaDataType<PersonSchema>? author;
  final SchemaDataType<PersonSchema>? creator;
  final String? copyrightHolder;
  final String? copyrightYear;
  final String? datePublished;
  final String? dateModified;
  final String? license;
  final String? acquireLicensePage;
  final String? creditText;
  final String? alternateName;
  final String? inLanguage;
  final List<String>? keywords;
  final Map<String, dynamic>? additionalProperties;

  /// Helper method to create image as Map for use in other schemas
  static Map<String, dynamic> toMap({
    required String url,
    String? caption,
    int? width,
    int? height,
    String? name,
  }) {
    return {
      '@type': 'ImageObject',
      'url': url,
      if (caption != null) 'caption': caption,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (name != null) 'name': name,
    };
  }

  /// Helper method to create EXIF data
  static Map<String, dynamic> createExifData({
    String? camera,
    String? lens,
    String? focalLength,
    String? aperture,
    String? shutterSpeed,
    String? iso,
    String? dateTime,
    String? gpsLatitude,
    String? gpsLongitude,
  }) {
    final exif = <String, dynamic>{};
    if (camera != null) exif['camera'] = camera;
    if (lens != null) exif['lens'] = lens;
    if (focalLength != null) exif['focalLength'] = focalLength;
    if (aperture != null) exif['aperture'] = aperture;
    if (shutterSpeed != null) exif['shutterSpeed'] = shutterSpeed;
    if (iso != null) exif['iso'] = iso;
    if (dateTime != null) exif['dateTime'] = dateTime;
    if (gpsLatitude != null) exif['gpsLatitude'] = gpsLatitude;
    if (gpsLongitude != null) exif['gpsLongitude'] = gpsLongitude;
    return exif;
  }
}

// Backward compatibility typedef
typedef ImageSchemaData = ImageSchema;
