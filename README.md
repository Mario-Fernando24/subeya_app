# 🚖 Subeya App

**Subeya** es una aplicación móvil desarrollada con **Flutter** que ofrece una experiencia moderna, eficiente y segura para la gestión y solicitud de servicios de transporte (tipo taxi o teletaxi).  

El proyecto implementa **Clean Architecture**, **BLoC/Cubit** para la gestión de estado, e integración con **Google Maps** para navegación y geolocalización en tiempo real.

---

## 📱 Características principales

- 🗺️ **Mapa interactivo con Google Maps**
  - Marcadores personalizados.
  - Actualización en tiempo real de la posición del usuario y conductor.
- 👤 **Gestión de usuarios**
  - Registro e inicio de sesión.
  - Actualización de perfil con imagen.
- 🚕 **Solicitud de servicios**
  - Visualización de conductores cercanos.
  - Creación y seguimiento de solicitudes de viaje.
- 📍 **Navegación entre rutas**
  - Visualización de origen y destino.
  - Trazado dinámico de rutas.
- 🔐 **Autenticación segura con tokens**
  - Persistencia de sesión mediante almacenamiento local.
- ⚙️ **Arquitectura limpia**
  - Separación clara entre `domain`, `data` y `presentation`.

---

## 🧩 Estructura del proyecto

```bash
lib/
├── src/
│   ├── data/
│   │   ├── datasources/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── api_repository_impl.dart
│   ├── domain/
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   ├── presentation/
│   │   ├── bloc/
│   │   │   ├── cubits/
│   │   │   ├── events/
│   │   │   ├── states/
│   │   │   └── blocs/
│   │   ├── pages/
│   │   ├── widgets/
│   │   └── themes/
│   └── main.dart
└── core/
    ├── utils/
    ├── constants/
    └── routes/

🏗️ Tecnologías utilizadas

| Tecnología                | Uso principal                                 |
| ------------------------- | --------------------------------------------- |
| **Flutter**               | Framework de desarrollo móvil multiplataforma |
| **Dart**                  | Lenguaje de programación                      |
| **BLoC / Cubit**          | Gestión de estado                             |
| **Clean Architecture**    | Organización modular y mantenible             |
| **Google Maps Flutter**   | Mapas y geolocalización                       |
| **HTTP / Dio**            | Consumo de APIs                               |
| **SharedPreferences**     | Almacenamiento local                          |
| **Image Picker / Camera** | Captura y selección de imágenes de usuario    |

⚙️ Configuración del entorno
1️⃣ Clonar el repositorio

git clone https://github.com/tuusuario/subeya_app.git
cd subeya_app

2️⃣ Instalar dependencias
flutter pub get

3️⃣ Configurar Google Maps

Agrega tus claves de API en los archivos:

Android (android/app/src/main/AndroidManifest.xml)
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="TU_API_KEY" />
iOS (ios/Runner/AppDelegate.swift)

GMSServices.provideAPIKey("TU_API_KEY")

🧠 Arquitectura general

El proyecto implementa Clean Architecture con tres capas principales:

Data layer: conexión con APIs y manejo de modelos.

Domain layer: lógica de negocio (use cases, entidades).

Presentation layer: interfaz de usuario y gestión de estado con BLoC.

Cada capa está desacoplada y depende de abstracciones, lo que facilita la mantenibilidad, escalabilidad y testeo del código.

🧑‍💻 Desarrollador

👨‍💻 Mario Fernando Muñoz Rivera
Ingeniero de software especializado en desarrollo móvil.
Apasionado por la arquitectura limpia, la innovación tecnológica y el impacto social del software.

📧 Correo: 3115408069.mafe@gmail.com

🌐 GitHub: Mario-Fernando24

🪪 Licencia

Este proyecto se distribuye bajo la licencia MIT.
Puedes usarlo, modificarlo y distribuirlo libremente citando al autor original.
