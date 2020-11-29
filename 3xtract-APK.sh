#!/bin/sh

cat << "EOF"
`;-.          ___,
  `.`\_...._/`.-"`
    \        /     ,
    /()   () \    .' `-._
   |)  .    ()\  /   _.'
   \  -\'-     ,; \'. <
    ;.__     ,;|   > \
   / ,    / ,  |.-\.-'
  (_/    (_/ ,;|.<`
    \    ,     ;-`
     >   \    /  3xtract-APK 
    (_,-'`> .'	 Author : Ghosthub
        (_,'
EOF




Application=$2
Tool=$1

file_base=`basename $Application .apk`
dist_dir="Results/"$file_base"_EXdata"

if [ ! -f $Application ]; then
	echo "[!]" $Application "not found !"
	exit
fi

jadxx(){

	if which jadx >/dev/null; then
		true
	else
  		echo "[!] You need to install JADX first ."
  		exit
	fi


	if [ -d "$dist_dir" ]; then
		true
	fi
		$(mkdir -p $dist_dir)
	echo "[+] Decompiling the application using jadx ... "

	jadx $Application -d $dist_dir > /dev/null
}


apkk(){

        if which apktool >/dev/null; then
                    true
        else
                echo "[!] You need to install APKTOOL first ."
                exit
        fi
	echo "[+] Decompiling the application using apktool... "

	$(apktool d $Application -o $dist_dir -q)
}




if [ -z "$Tool" ];then
	echo "[*] USAGE : ./3xtract-APK.sh  JADX/APKTOOL file.apk "
	exit

elif [ "$Tool" = "APKTOOL" ] || [ "$Tool" = "apktool" ];then
	apkk

elif [ "$Tool" = "JADX" ] || [ "$Tool" = "jadx" ];then
	jadxx

else
	echo "[!] use one from list (JADX/APKTOOL)"
	echo "[*] USAGE : ./3xtract-APK.sh  JADX/APKTOOL file.apk "
	exit
fi

echo "[+] Application Successfully Decompiled ^.^ "
sleep 2
echo "[+] Extracting importants data from the application ... "

python Extract.py $dist_dir $Tool

echo "[+] Well done Bro!"
