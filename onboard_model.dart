class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      title: "Organize",
      image: 'images/on1.png',
      description: "Build your Events"),

  UnboardingContent(
      title: "Share",
      image: 'images/on2.jpg',
      description:
          "Present your Portfolio"),
  UnboardingContent(
      title: "Network",
      image: 'images/on3.jpg',
      description:
          "Interact with Peer Groups"),
];
