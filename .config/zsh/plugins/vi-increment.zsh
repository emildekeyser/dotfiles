#!/usr/bin/env zsh

# # {{{ Handle fpath/$0
# # ref: zdharma.org/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#zero-handling
# 0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
# 0="${${(M)0:#/*}:-$PWD/$0}"
# if [[ $zsh_loaded_plugins[-1] != */vi-increment && -z $fpath[(r)${0:h}] ]]
# then
#     fpath+=( "${0:h}" )
# fi
# # }}}

function vi-crement()
{

    # take numeric prefix to command
    zle -f vichange
    # emulate -L zsh
    setopt extendedglob
    # start|end:        hex/other number start or end
    # odec_(start|end): the start or end of the longest matching [[:digit:]] string
    # odec:             this matches a octal|decimal number
    # c(hex|bin):       this matches a 0x[hex] or 0b[bin] number
    # zero:             this number has leading zeroes to preserve
    # d:                the numeric change requested
    # (s)ans:           the answer, in numeric or (s)tring format
    local sans
    local -i d ans start end odec_start odec_end odec cbin chex zero
    # We don't detect octal, instead we let zsh (( arithmetic )) gate it:
    # If `setopt octalzerores` and an invalid octal number (like 08), the increment will fail

    case ${WIDGET} in
        vi-dec*) d=0-${NUMERIC:-'1'} ;;
        *) d=${NUMERIC:-'1'} ;;
    esac

    # visual mode
    if (( REGION_ACTIVE )); then
        cbin=0 chex=0 odec=0 zero=0
        if (( MARK > CURSOR )); then
        end=1+MARK start=1+CURSOR
    else
    end=1+CURSOR start=1+MARK
        fi
        odec_start=$start odec_end=$end
        case $BUFFER[start,end] in
            -#0[bB]0*) zero=1 ;&
            -#0[bB]* ) cbin=1 ;;
            -#0[xX]0*) zero=1 ;&
            -#0[xX]* ) chex=1 ;;
            -#0*) zero=1 ;&
            * ) odec=1  ;;
        esac
    else
        # not visual, must parse BUFFER
        odec=1 cbin=1 chex=0 zero=0
        start=CURSOR+1 end=CURSOR
        odec_start=start odec_end=end
        # forwards
        while (( ++end <= $#BUFFER )); do
            case $BUFFER[end] in
                [2-9]) cbin=0 ;&
                [01_]) (( odec )) && (( odec_end=end )) ;;
                [[:xdigit:]]) odec=0 ;;
                *)
                    (( end-- ))
                    break
                    ;;
            esac
        done

        # backwards
        while
            case $BUFFER[start] in
                0)
                    zero=1
                    (( odec )) && (( odec_start=start ))
                    ;;
                [2-9]) cbin=0 ;&
                [1_])
                    zero=0
                    (( odec )) && (( odec_start=start ))
                    ;;
                [bB])
                    if (( cbin )) && [[ $BUFFER[start-2,start-1] = [^[:alnum:]]#0 ]]
                    then
                        odec=0
                        (( start -= 2 ))
                    else
                        # may be in a hex number
                        if [[ $BUFFER[--start] = [[:xdigit:]xX] ]]; then
                            zero=0 odec=0
                            continue
                        fi
                        odec=1
                        (( start += 2 ))
                    fi
                    break
                    ;;
                [[:xdigit:]])
                    zero=0 odec=0
                    ;;
                [xX])
                    cbin=0
                    if [[ $BUFFER[start-2,start-1] = [^[:alnum:]]#0 ]]
                    then
                        odec=0 chex=1
                        (( start -= 2 ))
                    else
                        odec=1
                        (( start++ ))
                    fi
                    break
                    ;;
                *)
                    odec=1
                    break
                    ;;
            esac
            (( --start ))
        do :; done
        # Detect negatives afterwards: makes alternate bases easier
        if [[ "$BUFFER[start]" = '-' ]]; then
            (( odec )) && (( odec_start=start ))
        else
            (( ++start ))
        fi
        # Invalid range: exit
        (( start > end )) && return
    fi
    if (( odec )); then
        start=odec_start
    end=odec_end
    ans=$(( BUFFER[odec_start,odec_end] + d ))
    elif (( cbin )); then
        # no cbases-0x[hex]-like option, have to manually strip prefix
        ans=$(( [#2] BUFFER[start,end] + d ))
        sans="${ans#'2#'}"
        (( start += 2 ))
    elif (( chex )); then
        setopt localoptions cbases
        ans=$(( [#16] BUFFER[start,end] + d ))
    fi
    if (( zero )); then
        local -Z $((1 + end - start )) ans
        ! (( chex )) && [[ $(setopt) = *cbases*octalzeroes* ]] && local -i 8 ans
    fi
    BUFFER="$BUFFER[1,start-1]${sans:=$ans}$BUFFER[end+1,$#BUFFER]"
    CURSOR=$(( start - 2 + ${#sans} ))
    MARK=$(( start - 1 ))

}
