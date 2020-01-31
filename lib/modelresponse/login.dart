class login {
  String status;

  List<Result> result;

  login({
    this.status,
    this.result
  });

  factory login.fromJson(Map<String, dynamic> json){
    return login(
      status: json["status"],
      result: List<Result>.from(json["result"].map((result){
        return Result.fromJson(result);
      }))
    );
  }
}

class Result {
  String username;

  Result({
    this.username,
  });

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      username: json["username"],
    );
  }

}