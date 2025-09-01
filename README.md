# 42env-mac

이 프로젝트는 macOS 사용자를 위한 42 Seoul(42cursus) 개발 환경을 Docker 컨테이너로 구축한 개인용 설정 저장소입니다. Linux 기반의 일관된 환경에서 작업하면서도 macOS의 편리한 기능(예: 클립보드)을 활용할 수 있도록 구성되었습니다.

## 주요 특징

* **운영체제**: Ubuntu 22.04 LTS를 기반으로 하는 Docker 컨테이너.

* **개발 도구**: `build-essential`, `gdb`, `valgrind`, `clangd` 등 42 환경에 필요한 필수 도구들이 사전 설치되어 있습니다.

* **터미널 환경**: `Zsh`, `Oh My Zsh`, `Powerlevel10k` 테마를 통해 시각적으로 풍부하고 기능적인 셸 환경을 제공합니다.

* **편집기**: `Neovim`을 `lazy.nvim` 플러그인 매니저를 사용하여 강력하게 커스터마이징했습니다.

  * `LSP` (Language Server Protocol) 및 `DAP` (Debug Adapter Protocol)을 통한 지능적인 코드 편집 및 디버깅.

  * `nvim-tree`를 사용한 파일 탐색기.

  * `lualine`을 사용한 상태 라인.

  * `gitsigns`을 사용한 Git 상태 표시.

  * `conform.nvim`을 사용한 `c_formatter_42` 기반의 코드 포맷팅 (`<leader>F`).

  * `telescope.nvim`을 사용한 퍼지 파인더.

* **터미널 멀티플렉서**: `Tmux`를 사용하여 창 및 패널 관리를 효율적으로 수행합니다.

* **macOS 연동**: X11 포워딩을 통해 컨테이너 내부에서도 macOS의 클립보드 기능(`pbcopy`/`pbpaste`)을 사용할 수 있습니다.

## 시작하기

### 1. 전제 조건

* [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/) 설치

* [XQuartz](https://www.xquartz.org/) 설치 및 설정

  * `XQuartz`의 `Preferences` > `Security` 탭에서 `Allow connections from network clients`를 활성화합니다.

  * 터미널에서 `xhost +localhost` 명령어를 실행하여 로컬 연결을 허용합니다.

### 2. 환경 구축

프로젝트 디렉토리로 이동하여 다음 명령어를 실행합니다.
```
docker build -t 42env:latest .
```

```
docker-compose up -d --build
```

컨테이너를 캐시 없이 재구축하려면:

```
docker-compose build --no-cache
```

```
docker-compose exec 42env zsh
```

컨테이너를 종료하려면:

```
docker-compose down
```

## 주요 설정 및 키맵

### Neovim (`.config/nvim/`)

* **리더 키**: `<Space>`

* **주요 키맵**:

  * `<leader>ee`: 파일 탐색기 토글

  * `<leader>ff`: 파일 찾기 (Telescope)

  * `<leader>fs`: 문자열 찾기 (Telescope live_grep)

  * `<leader>rn`: 이름 변경 (LSP)

  * `<leader>F`: 파일 저장 및 포맷팅 (Conform)

### Tmux (`.tmux.conf`)

* **프리픽스**: `C-a`

* **주요 키맵**:

  * `<prefix> |`: 수평 패널 분할

  * `<prefix> -`: 수직 패널 분할

  * `<prefix> h/j/k/l`: 패널 크기 조절

  * `Ctrl-h/j/k/l`: 패널 이동 (`vim-tmux-navigator` 플러그인)

### Zsh (`.zshrc`, `.p10k.zsh`)

* **테마**: `Powerlevel10k`

* **플러그인**: `zsh-autosuggestions`, `zsh-syntax-highlighting`

* **주요 별칭(Alias)**:

  * `vim`: `nvim`

  * `cd`: `z` (zoxide)

  * `cl`: `clear`

  * `norm`: `norminette`

## 라이선스

이 프로젝트의 코드는 특정 개인의 설정을 담고 있으며, 상업적 목적이 아닌 개인 학습 및 개발 환경 구축을 위해 참고용으로 공개되었습니다.로젝트 디렉토리로 이동하여 다음 명령어를 실행합니다.
