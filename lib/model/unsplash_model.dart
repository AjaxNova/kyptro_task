class ImageData {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? promotedAt;
  final int? width;
  final int? height;
  final String? color;
  final String? blurHash;
  final int? likes;
  final bool? likedByUser;
  final String? description;
  final String? altDescription;
  final Urls? urls;
  final Links? links;
  final User? user;

  ImageData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.likes,
    this.likedByUser,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.user,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      promotedAt: json['promoted_at'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      color: json['color'] as String?,
      blurHash: json['blur_hash'] as String?,
      likes: json['likes'] as int?,
      likedByUser: json['liked_by_user'] as bool?,
      description: json['description'] as String?,
      altDescription: json['alt_description'] as String?,
      urls: json['urls'] != null
          ? Urls.fromJson(json['urls'] as Map<String, dynamic>)
          : null,
      links: json['links'] != null
          ? Links.fromJson(json['links'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Urls {
  final String? raw;
  final String? full;
  final String? regular;
  final String? small;
  final String? thumb;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
      raw: json['raw'] as String?,
      full: json['full'] as String?,
      regular: json['regular'] as String?,
      small: json['small'] as String?,
      thumb: json['thumb'] as String?,
    );
  }
}

class Links {
  final String? self;
  final String? html;
  final String? download;
  final String? downloadLocation;

  Links({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'] as String?,
      html: json['html'] as String?,
      download: json['download'] as String?,
      downloadLocation: json['download_location'] as String?,
    );
  }
}

class User {
  final String? id;
  final String? username;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? twitterUsername;
  final String? portfolioUrl;
  final String? bio;
  final String? location;
  final UserLinks? links;

  User({
    this.id,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      twitterUsername: json['twitter_username'] as String?,
      portfolioUrl: json['portfolio_url'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      links: json['links'] != null
          ? UserLinks.fromJson(json['links'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserLinks {
  final String? self;
  final String? html;
  final String? photos;
  final String? likes;
  final String? portfolio;
  final String? following;
  final String? followers;

  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) {
    return UserLinks(
      self: json['self'] as String?,
      html: json['html'] as String?,
      photos: json['photos'] as String?,
      likes: json['likes'] as String?,
      portfolio: json['portfolio'] as String?,
      following: json['following'] as String?,
      followers: json['followers'] as String?,
    );
  }
}
