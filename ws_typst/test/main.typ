// Typst Test Document
#set document(title: "Documento de Prueba", author: "Alejandro Gomez")
#set page(numbering: "1")
#set text(lang: "es")

#align(center)[
  #text(size: 20pt, weight: "bold")[Documento de Prueba]
  
  #v(0.5em)
  
  Alejandro Gomez
  
  #v(0.5em)
  
  #datetime.today().display()
]

#v(1em)

= Introducción

Este es un documento de prueba para verificar que la compilación de Typst con `Docker` funciona correctamente.

Typst es un sistema de composición tipográfica moderno que ofrece:
- Compilación rápida y eficiente
- Sintaxis más limpia e intuitiva que LaTeX
- Mensajes de error claros y útiles
- Características modernas integradas

= Contenido

El sistema está configurado para compilar automáticamente archivos Typst siguiendo los siguientes pasos:

+ Crear una carpeta en el directorio `ws_latex` con el código fuente de Typst. \
  Ejemplo: `ws_latex/<nombre_de_la_carpeta>`

+ Compilar usando el script `./scripts/compile.sh` \
  Ejemplo: `./scripts/compile.sh <nombre_de_la_carpeta>`

+ Revisar el archivo PDF generado en la carpeta. \
  Ejemplo: `ws_latex/<nombre_de_la_carpeta>/main.pdf`

== Características de Typst

Typst ofrece varias ventajas sobre LaTeX tradicional:

- *Velocidad*: Compilación casi instantánea
- *Sintaxis*: Más moderna e intuitiva
- *Errores*: Mensajes claros y precisos
- *Funciones*: Scripting integrado con funciones potentes

=== Ejemplo de Código

Puedes incluir código fácilmente:

```python
def hello_world():
    print("Hello from Typst!")
```

=== Fórmulas Matemáticas

Las fórmulas matemáticas se escriben de forma similar a LaTeX:

$ sum_(i=1)^n i = (n(n+1))/2 $

$ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $

= Conclusión

Si puedes leer este PDF, el compilador Docker con Typst está funcionando correctamente. 🎉

#v(1em)

#align(center)[
  _¡Disfruta usando Typst!_
]

