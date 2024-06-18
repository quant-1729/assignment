

class PostDTO {
  final String id;
  final String userId;
  final String description;
  final String title;
  final List<String> image;
  final List<String> tags;
  final List<String> likedUsers;
  final String eventCategory;
  final String eventStartAt;
  final String eventEndAt;
  final String eventId;
  final bool registrationRequired;
  final List<String> registration;
  final String eventDescription;
  final int likes;
  final List<String> comments;
  final String createdAt;

  PostDTO({
    required this.id,
    required this.userId,
    required this.description,
    required this.title,
    required this.image,
    required this.tags,
    required this.likedUsers,
    required this.eventCategory,
    required this.eventStartAt,
    required this.eventEndAt,
    required this.eventId,
    required this.registrationRequired,
    required this.registration,
    required this.eventDescription,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  // Factory constructor to create a PostDTO from a JSON map
  factory PostDTO.fromJson(Map<String, dynamic> json) {
    return PostDTO(
      id: json['_id'],
      userId: json['userId'],
      description: json['description'],
      title: json['title'],
      image: List<String>.from(json['image']),
      tags: List<String>.from(json['tags']),
      likedUsers: List<String>.from(json['likedUsers']),
      eventCategory: json['eventCategory'],
      eventStartAt: json['eventStartAt'],
      eventEndAt: json['eventEndAt'],
      eventId: json['eventId'],
      registrationRequired: json['registrationRequired'],
      registration: List<String>.from(json['registration']),
      eventDescription: json['eventDescription'],
      likes: json['likes'],
      comments: List<String>.from(json['comments']),
      createdAt: json['createdAt'],
    );
  }

  // Method to convert a PostDTO to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'description': description,
      'title': title,
      'image': image,
      'tags': tags,
      'likedUsers': likedUsers,
      'eventCategory': eventCategory,
      'eventStartAt': eventStartAt,
      'eventEndAt': eventEndAt,
      'eventId': eventId,
      'registrationRequired': registrationRequired,
      'registration': registration,
      'eventDescription': eventDescription,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt,
    };
  }
}
