# LBI Plugin

RisuAI용 LBI 플러그인 - Rollup 모듈화 버전

## 개발 환경 설정

```bash
# 의존성 설치
npm install

# 빌드 (단일 파일로 번들링)
npm run build

# 워치 모드 (파일 변경 시 자동 빌드)
npm run watch
```

## 프로젝트 구조

```
lbi/
├── src/
│   ├── index.js           # 메인 플러그인 코드
│   └── config/            # 설정 모듈 (점진적 분리 중)
│       ├── constants.js   # 상수 정의
│       ├── enums.js       # 열거형 정의
│       └── index.js       # 통합 export
├── dist/                  # 빌드 산출물 (gitignore)
├── package.json
├── rollup.config.js
└── LBI-0.35.0-pre26_Refactored.js  # 원본 파일 (백업)
```

## 사용 방법

1. `npm run build`로 빌드
2. `dist/LBI-0.35.0-pre26_Refactored.js`를 RisuAI에 로드

## 라이선스

- 플러그인: GPL-3.0
- 외부 의존성:
  - aws4fetch: MIT
  - uuid: MIT
  - streamsaver: MIT
  - fflate: MIT
