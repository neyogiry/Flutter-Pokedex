class ImageHelper {

  static String pokemonImageUrl(String url) {
    List<String> splitted = url.split("/");
    splitted.removeLast();
    int index = int.parse(splitted.last);
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$index.png";
  }

}