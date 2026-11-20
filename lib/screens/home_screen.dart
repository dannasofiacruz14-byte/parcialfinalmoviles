import 'package:flutter/material.dart';

import '../models/covid_data.dart';
import '../services/covid_api.dart';
import '../services/notification_service.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/app_header.dart';
import '../widgets/country_header.dart';
import '../widgets/country_selector.dart';
import '../widgets/error_view.dart';
import '../widgets/hero_stat.dart';
import '../widgets/stat_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Clave: nombre que entiende la API (en inglés). Valor: lo que ve la persona.
  static const countries = {
    'Colombia': 'Colombia',
    'Mexico': 'México',
    'Argentina': 'Argentina',
    'Peru': 'Perú',
    'Chile': 'Chile',
    'Spain': 'España',
    'USA': 'Estados Unidos',
  };

  String selected = 'Colombia';
  late Future<CovidData> future = fetchCountry(selected);

  void _reload() {
    setState(() {
      future = fetchCountry(selected);
    });
  }

  Future<void> _notify(CovidData d) async {
    await NotificationService.show(
      title: 'COVID-19: ${d.country}',
      body: 'Casos: ${formatNumber(d.cases)} | '
          'Muertes: ${formatNumber(d.deaths)} | '
          'Hoy: ${formatNumber(d.todayCases)}',
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notificación enviada: ${d.country}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _friendlyError(Object? error) {
    final text = error.toString();
    if (text.contains('SocketException') ||
        text.contains('ClientException') ||
        text.contains('Timeout')) {
      return 'Revisa tu conexión a internet e inténtalo de nuevo.';
    }
    return text.replaceFirst('Exception: ', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            child: CountrySelector(
              value: selected,
              countries: countries,
              onChanged: (value) {
                if (value == null) return;
                selected = value;
                _reload();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<CovidData>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return ErrorView(
                    message: _friendlyError(snapshot.error),
                    onRetry: _reload,
                  );
                }
                return _buildContent(snapshot.data!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(CovidData d) {
    const divider = Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.line,
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            children: [
              CountryHeader(
                country: d.country,
                flag: d.flag,
                updated: formatDate(d.updated),
              ),
              const SizedBox(height: 20),
              HeroStat(
                label: 'Casos acumulados',
                value: formatNumber(d.cases),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.line),
                ),
                child: Column(
                  children: [
                    StatRow(
                      icon: Icons.trending_up_rounded,
                      label: 'Casos del día',
                      value: formatNumber(d.todayCases),
                      color: AppColors.todayCases,
                    ),
                    divider,
                    StatRow(
                      icon: Icons.heart_broken_rounded,
                      label: 'Muertes acumuladas',
                      value: formatNumber(d.deaths),
                      color: AppColors.deaths,
                    ),
                    divider,
                    StatRow(
                      icon: Icons.show_chart_rounded,
                      label: 'Muertes del día',
                      value: formatNumber(d.todayDeaths),
                      color: AppColors.todayDeaths,
                    ),
                    divider,
                    StatRow(
                      icon: Icons.health_and_safety_rounded,
                      label: 'Recuperados',
                      value: formatNumber(d.recovered),
                      color: AppColors.recovered,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 18, color: AppColors.muted),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Los datos de COVID ya no se actualizan como antes: la '
                      'fecha puede ser reciente aunque las cifras sean '
                      'históricas.',
                      style: TextStyle(fontSize: 12.5, color: AppColors.muted),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: FilledButton.icon(
              onPressed: () => _notify(d),
              icon: const Icon(Icons.notifications_active_rounded),
              label: const Text('Enviar notificación'),
            ),
          ),
        ),
      ],
    );
  }
}