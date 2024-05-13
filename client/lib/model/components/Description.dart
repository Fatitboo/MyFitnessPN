class Description {
  String? title;
  String? content;

  Description({
    this.title,
    this.content,
  });


  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      title: json["title"] ?? "",
      content: json["content"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
}