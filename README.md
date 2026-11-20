# Datos COVID-19 · Flutter

App Flutter para Android que consulta la API pública [disease.sh](https://disease.sh),
convierte el JSON en un modelo de Dart, muestra las cifras de un país y envía una
notificación local con el resumen.


## Dependencias (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  flutter_local_notifications: ^19.0.0
```

No uses `flutter pub add`: instalaría una versión más nueva del plugin de
notificaciones, incompatible con este código.

## Configuración de Android

1. `android/app/src/main/AndroidManifest.xml`, dentro de `<manifest>` y antes de `<application>`:

   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
   ```

2. `android/app/build.gradle.kts` (necesario para que las notificaciones compilen):

   ```kotlin
   android {
       compileOptions {
           isCoreLibraryDesugaringEnabled = true
       }
   }

   dependencies {
       coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
   }
   ```

## Ejecutar

```
flutter pub get
flutter run
```


## Ampliaciones incluidas

- Bandera del país con `countryInfo.flag` y `Image.network`.
- Notificación expandible con `BigTextStyleInformation`.
- Interfaz separada en widgets pequeños y reutilizables.