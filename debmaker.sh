#!/usr/bin/bash

#-------------Coder details-----------------

# coder : abijith@NNC
# Teacher : suman@BHUTUU
# description : its an automation tool used to make debian packages

#-------------------------------------------

#--------- Colour used -----------
S0="\033[1;30m" B0="\033[1;40m"
S1="\033[1;31m" B1="\033[1;41m"
S2="\033[1;32m" B2="\033[1;42m"
S3="\033[1;33m" B3="\033[1;43m"
S4="\033[1;34m" B4="\033[1;44m"
S5="\033[1;35m" B5="\033[1;45m"
S6="\033[1;36m" B6="\033[1;46m"
S7="\033[1;37m" B7="\033[1;47m"
R0="\033[00m"   R1="\033[1;00m"
# -------------------------------

#------------Programe--------------

echo -e "
			
		██████╗░███████╗██████╗░  ███╗░░░███╗░█████╗░██╗░░██╗███████╗██████╗░
		██╔══██╗██╔════╝██╔══██╗  ████╗░████║██╔══██╗██║░██╔╝██╔════╝██╔══██╗
		██║░░██║█████╗░░██████╦╝  ██╔████╔██║███████║█████═╝░█████╗░░██████╔╝
		██║░░██║██╔══╝░░██╔══██╗  ██║╚██╔╝██║██╔══██║██╔═██╗░██╔══╝░░██╔══██╗
		██████╔╝███████╗██████╦╝  ██║░╚═╝░██║██║░░██║██║░╚██╗███████╗██║░░██║
		╚═════╝░╚══════╝╚═════╝░  ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝" | pv -qL 300 | lolcat
echo
printf "\033[1;36mit is an automation tool created by abijith@NNC to make your programe to deb file \033[00m\n"
echo
printf "${B1}warning :${R1} ${S6}ONLY KEEP THIS TOOL IN THE HOME OF TERMUX ${R0}\n"
echo
printf "${S4}This is only a tool that is used to make deb file of prebuilt programe or any github projects! ${B2}PRESS ENTER TO CONTINUE... ${R1}${R0}\n"
read
echo
printf "${S4}Enter the name you want to give to your deb file [NOT USE SPECIAL CHARACTERS, SYMBOLS, SPACE]==> ${R0}"
read name

mkdir $name
cd $name
pathtofolder=$(pwd)
mkdir DEBIAN
mkdir -p data/data/com.termux/files/usr
cd data/data/com.termux/files/usr
mkdir share bin
cd share
printf "${S4}Enter any name to your folder to save your programs files and directorys==> ${R0}"
read folder_name
mkdir $folder_name
cd $folder_name
path=$(pwd)
cd $HOME

while true; do
	echo
	printf "${S4}Enter the path of your program folder to copy your program to make deb==> ${R0}"
	read prg_path
	if [ -d "$prg_path" ]; then
		printf "${S2}FOLDER FOUNDED ${R0}\n"
		break
	else
		printf "${S1}FOLDER NOT FOUNDED, TRY AGAIN....! ${R0}\n"
	fi
done
echo
cd ${prg_path}
printf "${S6}files and directorys founded in your your folder are:- ${R0}\n"
echo
ls
printf "\n"
printf "${S4}Copying all files and directorys from ${prg_path} to ${path} that you created ${R0}\n"
echo
cp -r * ${path}

printf "\033[?25l"

printf "[->                ]\r"
sleep 1
printf "[  ->              ]\r"
sleep 1
printf "[    ->            ]\r"
sleep 1
printf "[       ->         ]\r"
sleep 1
printf "[          ->      ]\r"
sleep 1
printf "[             ->   ]\r"
sleep 1
printf "[                ->]\r"

printf "\033[?25h"
echo
printf "${S2}copyed files and directorys successfully ${R0}\n"

cd ${path}
cd ../..
cd bin
echo
printf "${S4}Enter any name to your launcher file to launch your programe==> ${R0}"
read launch
echo

while true; do
	printf "${S4}What is the name of your main programe file that used to run your programe${S1}[WITH EXTENTION]==> ${R0}"
	read mainfile

	if [ -f "${path}/${mainfile}" ]; then
		echo
		printf "${S2}File founded ${R0}\n"
		break
	else
		echo
		printf "${S1}File not founded. Try again ${R0}\n"
	fi
done
echo
printf "${S4}Which programing language you used to make that main file[${mainfile}]==> ${R0}"
read lang
echo
printf "${S6}Please wait! Making launcher file in name ${launch} ${R0}\n"
sleep 1
printf "${S6}Adding requirments to ${launch} file ${R0}\n"
sleep 1

cat <<- nnc > ${launch}
pathofprgm=${path}/${mainfile}
${lang} \${pathofprgm}
nnc
chmod +x ${launch}
echo
printf "${S2}Launcher file created successfully${R0}\n"
echo
cd ../../../../../..
cd DEBIAN
echo
printf "${S4}NOW STEP TO CREATE CONTROL FILE ${R0}\n"
echo
printf "${S4}Enter the package name==> ${R0}"
read pack
printf "\n${S2}Availabe architectures: 
1. all
2. aarch64
3. arm
4. i686
5. x86_64${R0}\n"
printf "${S4}Enter the index of your program Architecture==> ${R0}"
read archindex
archList=(all aarch64 arm  i686 x86_64)
selectedArch=${archList[$(($archindex - 1))]}
printf "${S4}Enter the Version of your programe==> ${R0}"
read vers

cd ..
cd ..
instasize=$(du -s $name | awk '{print $1}')
cd $name/DEBIAN

printf "${S4}Enter Maintainer's name==> ${R0}"
read maintain
printf "${S4}Enter the Home page link==> ${R0}"
read homelink


printf "${S4}Enter the Depends of your programe[SEPARATED BY COMMAS]==> ${R0}"
read input
IFS=',' read -ra val <<< "$input"
joined_values=$(printf "%s," "${val[@]}")
depends=${joined_values%,}
printf "${S4}Enter Description for this package==> ${R0}"; read DESCRIPT
cat <<- coder > control
Package: ${pack}
Architecture: ${selectedArch}
Version: ${vers}
Installed-Size: ${instasize}
Maintainer: ${maintain}
Homepage: ${homelink}
Depends: ${depends}
Description: ${DESCRIPT}
coder

printf "${S6}Giving permission to DEBIAN file..... ${R0}\n"
sleep 1
cd ..
chmod 0755 DEBIAN
cd ..

dpkg-deb -b ${name}

if [ $? -eq 0 ]; then
    printf "${S2}DEB package created successfully ${R0}\n"
else
    printf "${S1}Something went wrong... ${R0}\n"
fi

