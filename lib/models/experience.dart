class Experience {
  final String cargo;
  final String empresa;
  final String fechaInicio;
  final String fechaFin;
  final String descripcion;

  Experience({
    required this.cargo,
    required this.empresa,
    required this.fechaInicio,
    required this.fechaFin,
    required this.descripcion,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      cargo: json['cargo'],
      empresa: json['empresa'],
      fechaInicio: json['fecha_inicio'],
      fechaFin: json['fecha_fin'],
      descripcion: json['descripcion'],
    );
  }
}

List<Map<String, String>> jsonStr = [
  {
    "cargo": "Desarrollador mobile Flutter",
    "empresa": "TCS - Bancolombia",
    "fecha_inicio": "Nov 2022",
    "fecha_fin": "Ene 2024",
    "descripcion": "Dev frontend Mobile Flutter"
  },
  {
    "cargo": "Desarrollador mobile",
    "empresa": "RedCap S.A.S",
    "fecha_inicio": "Jun 2022",
    "fecha_fin": "Oct 2022",
    "descripcion": "Dev frontend Mobile Flutter"
  },
  {
    "cargo": "Desarrollador de software",
    "empresa": "Adomi APP",
    "fecha_inicio": "Abr 2021",
    "fecha_fin": "May 2022",
    "descripcion": "Dev frontend Mobile Flutter"
  },
  {
    "cargo": "Desarrollador de software Mobile",
    "empresa": "Comunix S.A.S",
    "fecha_inicio": "Ago 2020",
    "fecha_fin": "Nov 2020",
    "descripcion": "Dev frontend Mobile Flutter"
  },
  {
    "cargo": "Desarrollador de software Mobile",
    "empresa": "Comunix S.A.S",
    "fecha_inicio": "Nov 2019",
    "fecha_fin": "Dic 2019",
    "descripcion": "Dev frontend Mobile java"
  },
  {
    "cargo": "APRENDIZ SENA",
    "empresa": "Banco Mundo Mujer",
    "fecha_inicio": "Abr 2019",
    "fecha_fin": "Oct 2019",
    "descripcion": "Soporte tecnico"
  }
];
