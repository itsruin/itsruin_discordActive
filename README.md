# itsruin_discordActive 
Discord Rich Presence for FiveM (vRP)

## 소개
HYBE 서버에서 사용되었던 디스코드(Discord) 활동 상태 표시 시스템입니다.<br/>
기존 시스템과의 차이점은 다음과 같습니다.

- GTA5 지역(도로) 명칭에 따른 실시간 위치 표시
- 플레이어 활동 상태 표시 (서 있는 중, 걷는 중, 뛰는 중 등등..)

## 설정 방법
1. https://discord.com/developers/application 에 접속하여 새로운 애플리케이션을 생성합니다.
2. `General Information`에 있는 `APPLICATION ID`를 확인합니다.
3. `Rich Presence`에서 `Rich Presence Assets`항목에 원하는 이미지 두 장를 업로드 합니다.
6. `lua/client/client.lua`에 해당 사항을 적용합니다.

```lua
local discordAppId = -- APPLICATION ID
local discordRichPresenceNameB = "" -- Rich Presence Assets (큰 이미지)
local discordRichPresenceNameS = "" -- Rich Presence Assets (작은 이미지)

-- .. code

SetDiscordRichPresenceAction(0, "디스코드", "https://discord.gg/") -- 디스코드 주소 (서버 링크)입력
SetDiscordRichPresenceAction(1, "서버접속", "fivem://connect/") -- 서버 주소 입력 (IP)
```
