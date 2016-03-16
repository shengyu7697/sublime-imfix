Ubuntu Sublime Text 3 輸入中文

## 環境配置
- Ubuntu 14.04 LTS 64bit
- Sublime Text 3 Build 3103 deb
- fcitx, fcitx-chewing

## 支援中文輸入法
ibus: InputHelper
fcitx: 用下列方式完美fix

### 編譯
gcc -shared -o libsublime-imfix.so sublime-imfix.c `pkg-config --libs --cflags gtk+-2.0` -fPIC
### 執行
LD_PRELOAD=./libsublime-imfix.so subl

P.S. 記得先將ibus的shortcut給disable

## 將so檔放置在Sublime目錄下
sudo cp libsublime-imfix.so /opt/sublime_text/
## fix subl command
vim /usr/bin/subl
```
exec /opt/sublime_text/sublime_text "$@"
```
改成
```
LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text "$@"
```

## fix 圖標連接
vim /usr/share/applications/sublime_text.desktop
```
Exec=/opt/sublime_text/sublime_text %F
```
改成
```
Exec=bash -c "LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so /opt/sublime_text/sublime_text %F"
```
## 參考
http://ajax-chen.blogspot.tw/2015/08/sublime-gcin.html
http://sklcc.github.io/blog/2014/11/21/how-to-input-chinese-in-sub/
https://github.com/lyfeyaj/sublime-text-imfix

## code
sublime-imfix.c 輸入框會隨著游標出現
sublime-imfix2.c 輸入框只會在最下方出現
