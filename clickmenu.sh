
trap ctrl_c EXIT

function ctrl_c() {
	echo -e "\033[?1003l$DEF_BKGD"
}

# Make sure there is room for menu
counter=$#
while (( counter > 0 ))
do
	echo
	(( counter-- ))
done

# Get the current row (after potentially scrolling to make room)

IFS=';' read -sdR -p $'\033[6n' ROW COL
ROW=${ROW#*[}
# Subtract the number of items to get the row of the first item
ROW=$(( $ROW - $# ))

# Go to the top of the empty space.
echo -ne "\033[$ROW;0H"

DEL_LINE="\033[0K\r"
DEF_BKGD="\033[49m"
DGY_BKGD="\033[100m"
LGY_BKGD="\033[47m"

titles=$(echo "$@" | awk '{for (i=1;i<=NF;i++) printf("%d %s\n", i, $i)}' )

# Print the menu for the first time and turn on mouse reporting
DELIMETER=$(echo -ne '\033')

echo -e "$titles\033[?1003h"
read -s -n 6 POS


LASTHIGHLIGHT=-1
while true
do
	selected=""
	if [[ $POS == *"$DELIMETER"* ]]; then

		#This is needed because sometimes the code isn't the correct length and is invalid for some reason.
		IFS=$DELIMETER read -s -a TPOS -n 6 <<< "$POS"
		BADCOUNT=${#TPOS[1]}
		while (( BADCOUNT != 5 ))
		do
			read -s -n $((5 - ${#TPOS[2]})) REMAININGCHARS
			POS="$DELIMETER${TPOS[2]}$REMAININGCHARS"

			IFS=$DELIMETER read -s -a TPOS -n 6 <<< "$POS"
			BADCOUNT=${#TPOS[1]}
		done

		if (( ${#POS} == 6 )); then

			X=$(($(printf '%d' "'${POS:4:1}") - 32));
			Y=$(($(printf '%d' "'${POS:5:1}") - 32));

			IDX=$((Y - ROW + 1))

			if (( LASTHIGHLIGHT != Y && LASTHIGHLIGHT != -1 )); then
				LHIDX=$(( LASTHIGHLIGHT - ROW + 1 ))
				echo -ne "\033[$LASTHIGHLIGHT;0H$DEL_LINE$LHIDX ${!LHIDX}$DEF_BKG"
			fi

			if (( IDX >= 1 && IDX <= ${#@} )); then

				echo -ne "\033[$Y;0H$DEL_LINE$LGY_BKGD$IDX ${!IDX}$DEF_BKG"

				LASTHIGHLIGHT=$Y

				if [[ "${POS:3:1}" = " " ]]; then
					selected=$(echo "${!IDX}" | sed -E "s/[[:cntrl:]]\[[0-9]*m//g")
					#read mouse up
					read -s -n 6 POS
				fi
			fi

			echo -ne "\033[$(( ROW + ${#@} )));0H$DEL_LINE"
		fi
	else
		case $POS in
		[0-9]|[0-9][0-9])
			selected=$(echo "${!POS}" | sed -E "s/[[:cntrl:]]\[[0-9]*m//g")
			;;
		d|dev)
			selected="develop"
			;;
		-)
			selected=$OLD_GBNAME
			;;
		esac
	fi
	if [[ ! -z "$selected" ]]; then
		echo -e "\033[?1003l"
		echo "Selected: $selected"
		git checkout "$selected"
		exit
		break
	fi
	read -s -n 6 POS
done
echo -e "\033[?1003l"
