/// 스페인어 숫자 단어 ↔ 아라비아 숫자 양방향 변환 유틸.
///
/// 목적:
/// - STT가 "veinte" 발화를 "20" 으로 반환하는 플랫폼 동작을 보정하기 위해
///   비교 단계에서 양쪽 텍스트의 숫자 표현을 숫자 형태로 통일 (normalizeToDigits).
/// - 사용자가 말한 결과를 화면에 표시할 때는 다시 스페인어 단어로 되돌려
///   자연스럽게 보이도록 한다 (digitsToWords).
///
/// 지원 범위: 0~99 전체 (30 초과는 "X y Y" 복합 형태), 100, 200~900(백의 자리),
/// 1000(mil). 시간/나이/가격 등 일상 표현을 충분히 커버한다.
class SpanishNumbers {
  SpanishNumbers._();

  /// 단일 단어로 표현되는 숫자. (31-99 는 "treinta y uno" 처럼 결합형이라 제외)
  static const Map<int, String> _singleWordForm = {
    0: 'cero',
    1: 'uno',
    2: 'dos',
    3: 'tres',
    4: 'cuatro',
    5: 'cinco',
    6: 'seis',
    7: 'siete',
    8: 'ocho',
    9: 'nueve',
    10: 'diez',
    11: 'once',
    12: 'doce',
    13: 'trece',
    14: 'catorce',
    15: 'quince',
    16: 'dieciséis',
    17: 'diecisiete',
    18: 'dieciocho',
    19: 'diecinueve',
    20: 'veinte',
    21: 'veintiuno',
    22: 'veintidós',
    23: 'veintitrés',
    24: 'veinticuatro',
    25: 'veinticinco',
    26: 'veintiséis',
    27: 'veintisiete',
    28: 'veintiocho',
    29: 'veintinueve',
    30: 'treinta',
    40: 'cuarenta',
    50: 'cincuenta',
    60: 'sesenta',
    70: 'setenta',
    80: 'ochenta',
    90: 'noventa',
    100: 'cien',
    200: 'doscientos',
    300: 'trescientos',
    400: 'cuatrocientos',
    500: 'quinientos',
    600: 'seiscientos',
    700: 'setecientos',
    800: 'ochocientos',
    900: 'novecientos',
    1000: 'mil',
  };

  /// 단어 → 숫자 lookup. 변이형(악센트 제거, 성별 변화) 포함.
  static final Map<String, int> _wordToDigit = _buildWordLookup();

  static Map<String, int> _buildWordLookup() {
    final m = <String, int>{};
    _singleWordForm.forEach((value, word) => m[word] = value);
    // 악센트 없는 형태 (STT가 악센트를 떨어뜨리는 경우 대비)
    m['dieciseis'] = 16;
    m['veintidos'] = 22;
    m['veintitres'] = 23;
    m['veintiseis'] = 26;
    // 1 의 변이형 (성별/아포코페)
    m['una'] = 1;
    m['un'] = 1;
    // 21 의 변이형
    m['veintiuna'] = 21;
    m['veintiún'] = 21;
    m['veintiun'] = 21;
    // 100 의 변이형
    m['ciento'] = 100;
    // 200~900 의 여성형
    m['doscientas'] = 200;
    m['trescientas'] = 300;
    m['cuatrocientas'] = 400;
    m['quinientas'] = 500;
    m['seiscientas'] = 600;
    m['setecientas'] = 700;
    m['ochocientas'] = 800;
    m['novecientas'] = 900;
    return m;
  }

  /// 스페인어 숫자 단어 → 아라비아 숫자 치환.
  /// "treinta y cinco" 같은 복합수도 "35" 로 병합.
  /// 입력은 이미 lowercase/trim 된 상태를 가정.
  static String normalizeToDigits(String text) {
    if (text.isEmpty) return text;
    final tokens = text.split(' ');
    final result = <String>[];
    var i = 0;
    while (i < tokens.length) {
      final tok = tokens[i];
      if (tok.isEmpty) {
        i++;
        continue;
      }
      final n = _wordToDigit[tok];
      if (n == null) {
        result.add(tok);
        i++;
        continue;
      }
      // "30~90 y N" 복합수 (treinta y cinco → 35). 단, y 다음 토큰이 1~9 단일 단어일 때만.
      if (n >= 30 && n <= 90 && n % 10 == 0 &&
          i + 2 < tokens.length && tokens[i + 1] == 'y') {
        final ones = _wordToDigit[tokens[i + 2]];
        if (ones != null && ones >= 1 && ones <= 9) {
          result.add('${n + ones}');
          i += 3;
          continue;
        }
      }
      result.add('$n');
      i++;
    }
    return result.join(' ');
  }

  /// 아라비아 숫자 → 스페인어 단어 (표시용).
  /// 지원 범위 밖 숫자는 원본 그대로 둠.
  static String digitsToWords(String text) {
    return text.replaceAllMapped(RegExp(r'\b\d+\b'), (match) {
      final raw = match.group(0)!;
      final n = int.tryParse(raw);
      if (n == null) return raw;
      return _numberToWord(n) ?? raw;
    });
  }

  static String? _numberToWord(int n) {
    final direct = _singleWordForm[n];
    if (direct != null) return direct;
    // 31~99: "tens y ones"
    if (n >= 31 && n <= 99) {
      final tens = (n ~/ 10) * 10;
      final ones = n % 10;
      final tensWord = _singleWordForm[tens];
      final onesWord = _singleWordForm[ones];
      if (tensWord != null && onesWord != null) {
        return '$tensWord y $onesWord';
      }
    }
    return null;
  }
}
