# Ubuntu Sublime Text 3 輸入中文
目前ibus沒有很好的解決方案只能使用InputHelper的方式輸入中文(建議改用fcitx)  
fcitx可用下列方式完美解決  
P.S. 網路上有另外一種版本只能讓輸入框顯示在最底下，此版本可以讓輸入框顯示在游標下

## 環境配置
- Ubuntu 14.04 LTS 64bit
- Sublime Text 3 Build 3103 deb
- fcitx, fcitx-chewing

### 1. 編譯
```
gcc -shared -o libsublime-imfix.so sublime-imfix.c `pkg-config --libs --cflags gtk+-2.0` -fPIC
```
### 2. 執行
```
LD_PRELOAD=./libsublime-imfix.so subl
```
P.S. 記得先將ibus的shortcut給disable  
以上步驟就可以支援中文輸入了，後續的步驟是設置command啟動與圖示啟動

## 3. 將so檔放置在Sublime目錄下
```
sudo cp libsublime-imfix.so /opt/sublime_text/
```

## 4. Fix subl Command
vim /usr/bin/subl
```
exec /opt/sublime_text/sublime_text "$@"
```
改成
```
LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text "$@"
```

## 5. Fix Unity Launchers
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
