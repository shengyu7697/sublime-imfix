# Ubuntu Sublime Text 3 輸入中文
目前ibus沒有很好的解決方案只能使用InputHelper的方式輸入中文(建議改用fcitx)  
fcitx可用下列方式完美解決  
P.S. 網路上有另外一種版本只能讓輸入框顯示在最底下，此版本可以讓輸入框顯示在游標下

## 環境配置
- Ubuntu 14.04 LTS 64bit and Sublime Text 3 Build 3103 deb
- Ubuntu 16.04 LTS 64bit and Sublime Text 3 Build 3143 deb
- fcitx, fcitx-chewing

## 使用步驟
使用下列指令可以跳過Setp 1-3, 直接看Step 4
```
make && sudo make install
```

### Step 1. 編譯
```
sudo apt-get install libgtk2.0-dev
gcc -shared -o libsublime-imfix.so sublime-imfix.c `pkg-config --libs --cflags gtk+-2.0` -fPIC
```
### Step 2. 執行
```
LD_PRELOAD=./libsublime-imfix.so subl
```
P.S. 記得先將ibus的shortcut給disable  
以上步驟就可以支援中文輸入了，後續的步驟是設置command啟動與圖示啟動

### Step 3. 將so檔放置在Sublime目錄下
```
sudo cp libsublime-imfix.so /opt/sublime_text/
```

### Step 4. Fix subl Command
sudo vim /usr/bin/subl
```
exec /opt/sublime_text/sublime_text "$@"
```
改成
```
LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text "$@"
```

### Step 5. Fix Unity Launchers (圖示連結)
sudo vim /usr/share/applications/sublime_text.desktop
```
Exec=/opt/sublime_text/sublime_text %F
```
改成
```
Exec=bash -c "LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so /opt/sublime_text/sublime_text %F"
```

### Step 6.文件預設用subl開啟
把gedit換成sublime-text  
Running on 13.04+, update the file: /etc/gnome/defaults.list.  
```
sudo sed -i 's/gedit.desktop/sublime_text.desktop/g' /etc/gnome/defaults.list
```
Pre-13.04:  
```
sudo sed -i 's/gedit.desktop/sublime_text.desktop/g' /usr/share/applications/defaults.list
```

## 參考
http://ajax-chen.blogspot.tw/2015/08/sublime-gcin.html  
http://sklcc.github.io/blog/2014/11/21/how-to-input-chinese-in-sub/  
https://github.com/lyfeyaj/sublime-text-imfix  
