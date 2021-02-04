

class Cast {

  List<Actor> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList ) {

    if ( jsonList == null ) return;

    jsonList.forEach((item) { 

      final actor = Actor.fromJsonMap(item);

      actores.add(actor);

    });

  }

}




class Actor {
  bool adult;
  int gender;
  int id;
  //Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  //Department department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    //this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    //this.department,
    this.job,
  });

  Actor.fromJsonMap( Map<String,dynamic> json) {

    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    //knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    //department = json['department'];
    job = json['job'];

  }


  getFoto(){

    if ( profilePath == null ){
      return 'data:image/jpeg;base64,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';
    } else {
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
    
  }




}



