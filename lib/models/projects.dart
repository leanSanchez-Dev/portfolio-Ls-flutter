class Project {
  String project;
  String empresa;
  String tag;
  String url;

  Project({
    required this.project,
    required this.empresa,
    required this.tag,
    required this.url,
  });

  // Método para crear una instancia de la clase desde un mapa (JSON)
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      project: json['project'],
      empresa: json['empresa'],
      tag: json['tag'],
      url: json['url'],
    );
  }
}

List<Map<String, String>> jsonPj = [
  {
    "project": "Bodecom",
    "empresa": "Comunix S.A.S",
    "tag": "Flutter",
    "url": "assets/slide/bodecom.jpeg",
  },
  {
    "project": "navipuntos",
    "empresa": "Comunix S.A.S",
    "tag": "Java",
    "url": "assets/slide/navi.jpeg",
  },
  {
    "project": "Neat",
    "empresa": "RedCap S.A.S",
    "tag": "Flutter",
    "url": "assets/slide/neat.jpeg",
  },
  {
    "project": "Adomi Pedidos",
    "empresa": "Adomi APP",
    "tag": "Flutter",
    "url": "assets/slide/pedidos.jpeg",
  },
  {
    "project": "Adomi Aliados",
    "empresa": "Adomi APP",
    "tag": "Flutter",
    "url": "assets/slide/aliados.jpeg",
  },
  {
    "project": "Gesport",
    "empresa": "Comunix S.A.S",
    "tag": "Java",
    "url": "assets/slide/gessport.jpeg",
  },
  {
    "project": "Portfolio",
    "empresa": "LeanSanchez-Dev",
    "tag": "Flutter",
    "url": "assets/slide/portafolio.jpeg",
  }
];
