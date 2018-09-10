
trap ctrl_c EXIT

function ctrl_c() {
	echo -e "\033[?1003l"
}

IFS=';' read -sdR -p $'\033[6n' ROW COL
ROW=${ROW#*[}

DEL_LINE="\033[0K\r"
DEF_BKGD="\033[49m"
DGY_BKGD="\033[100m"
LGY_BKGD="\033[47m"

titles=$(echo "$@" | sed 's/ /\\n/g')

echo -e "$titles\033[?1003h"
read -s -n 6 POS
while true
do
	selected=""
	if (( ${#POS} == 6 )); then

		X=$(($(printf '%d' "'${POS:4:1}") - 32));
		Y=$(($(printf '%d' "'${POS:5:1}") - 32));

		echo -ne "\033[$ROW;0H"
		IDX=0
		for title in "$@"; do
			LEN=${#title}
			if (( $Y == (( ROW + IDX )) && $X <= $LEN)); then
				if [[ "${POS:3:1}" = " " ]]; then
					echo -ne "$DEL_LINE$DGY_BKGD$title$DEF_BKGD"
					selected=$(echo "$title" | sed -E "s/[[:cntrl:]]\[m//g")
				else
					echo -ne "$DEL_LINE$LGY_BKGD$title$DEF_BKGD"
				fi
			else
				echo -ne "$DEL_LINE$title"
			fi
			echo -ne "\n\033[2K\r"
			(( IDX++ ))
		done
	else
		echo $POS
	fi
	if [[ ! -z "$selected" ]]; then
		echo -e "\033[?1003l"
		git checkout "$selected"
		exit
	fi
	read -s -n 6 POS
done
echo -e "\033[?1003l"