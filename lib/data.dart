class Article {
  final String heading;
  final String description;
  final String postedTime;
  final String linktoStory;
  final String mediaData;

  Article({
    required this.heading,
    required this.description,
    required this.postedTime,
    required this.linktoStory,
    required this.mediaData,
  });
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      heading: map['heading'],
      description: map['description'],
      postedTime: map['postedTime'],
      linktoStory: map['linktoStory'],
      mediaData: map['imageUrl'],
    );
  }
}

final List<Article> data = [
  Article(
    heading: "1 in 4 delivery workers say they have tried your food",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    postedTime: "Today",
    linktoStory: "https://flutter.dev/",
    mediaData: "assets/bridge.gif",
  ),
  Article(
      heading: "This vegan cheese claims to taste like real cheese",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      postedTime: "Today",
      linktoStory: "https://flutter.dev/",
      mediaData: "assets/storm.gif"),
  Article(
      heading: "PM Modi to launch Indian Space Association today",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      postedTime: "Today",
      linktoStory: "https://flutter.dev/",
      mediaData: "assets/fire.gif")
];
