import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // weatherProvider 구독
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('날씨 정보'),
      ),
      body: weatherAsync.when(
        data: (weather) {
          // JSON 데이터에서 필요한 정보 추출
          final locationName = weather['name'] ?? 'Unknown Location';
          final temperature = (weather['main']['temp'] - 273.15)
              .toStringAsFixed(1); // Kelvin -> Celsius
          final weatherDescription =
              weather['weather'][0]['description'] ?? 'No description';
          final windSpeed = weather['wind']['speed'] ?? 0.0;
          final humidity = weather['main']['humidity'] ?? 0;
          final iconCode = weather['weather'][0]['icon'] ?? '01d';

          // 날씨 아이콘 URL 생성
          final iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locationName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Image.network(iconUrl, width: 100, height: 100),
                const SizedBox(height: 16),
                Text(
                  '$temperature°C',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  weatherDescription,
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                Text(
                  'Wind Speed: $windSpeed m/s',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Humidity: $humidity%',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('오류 발생: $error'),
        ),
      ),
    );
  }
}
