# 학습 데이터 — 원본 하나 · 언어별 번역 · 서버 배포 (2026-10-29)

## 구조

    content-src/master/<레벨>.json   ⭐ 문제마다 «스페인어 부분» 의 원본 하나 (master.py build 가 만든다)
    assets/data/questions/<언어>/    앱이 읽는 파일 — 스페인어는 원본 그대로 · 나머지(질문 문구 · 설명 · 힌트 · 뜻 보기)만 그 언어
    assets/data/questions/meta/      문제 종류 · 번역 방향(실제 내용에 맞춰 master.py 가 고친다)
    content-cdn/                     Cloudflare 정적 파일 — publish.py 가 채운다(손대지 않는다)

    🔴 규칙 — **같은 번호 = 같은 스페인어 문제.** 언어가 바뀌어도 바뀌는 것은 설명하는 말뿐이다

## 도구

    python3 tools/content/master.py build      15개 언어에서 원본을 다시 세운다(영어 기본 · 번역 문제는 실제 스페인어 쪽을 잰다)
    python3 tools/content/master.py repair     스페인어 부분을 기계로 원본에 맞추고, 번역이 필요한 것을 retranslate.json 에
    python3 tools/content/master.py check      언어마다 원본과 같은 문제인가
    python3 tools/content/translate.py --plan  번역할 것(원본과 다른 것 + 영어가 섞인 칸)
    python3 tools/content/translate.py         Claude Code CLI(`claude -p` · API 키 없음)로 25문제씩 4갈래 병렬 번역
                                               → 스페인어가 바뀌었거나 보기가 깨진 결과는 버린다
    python3 tools/content/publish.py           검사(JSON · 정답이 오답에 섞였나 · 원본과 같은가) → 통과해야 Cloudflare 배포

## 매일 새 문제 넣기

    ① 영어판(assets/data/questions/en/<레벨>.json)과 meta 에 새 번호로 문제를 넣는다 — 스페인어는 여기서 정한다
    ② master.py build → repair  (새 번호는 다른 언어에 없으니 전부 번역 대기열로)
    ③ translate.py  → 14개 언어
    ④ publish.py  → 앱은 다음 실행 때 바뀐 파일만 받는다(업데이트 없이)
    🔵 새 «주제» 면 topics_meta · topics_<언어> 도 같이 — 검사기에 «주제 짝» 검사를 더할 것

## 10-29 에 찾은 것 (기록 · 🙋 영상 재료로는 안 쓴다)

    ru vocab_c1 — 같은 주제로 따로 만든 다른 문제 묶음(120 중 같은 번호 같은 단어 1)
    it — 파일에 일본어 문제가 들어 있었다
    ja — 스페인어에서 «a» 가 빠짐(ven a visitarnos → ven visitarnos)
    th — 스페인어 낱말 속을 번역(sentencia → sen10cia)
    de · es — 단어 바꿔치기 번역(«Der/die/das book ist on der/die/das table.»)
    meta — 번역 방향 표시 21건이 내용과 반대 → 앱이 영어 질문을 스페인어 음성으로 읽을 수 있었다
    복구 — 스페인어 부분 기계 복구 1,169건 · 번역 약 1,500건(translate.py)
