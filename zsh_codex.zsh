# Check env variable ZSH_CODEX_HIGHLIGHT_COLOR does not exist
if [[ -z "$ZSH_CODEX_HIGHLIGHT_COLOR" ]]; then
    # Set ZSH_CODEX_HIGHLIGHT_COLOR to default value
    ZSH_CODEX_HIGHLIGHT_COLOR="#cc33ff"
fi

# Check env variable ZSH_CODEX_HOME does not exist
if [[ -z "$ZSH_CODEX_HOME" ]]; then
    # Set ZSH_CODEX_HOME to default value
    ZSH_CODEX_HOME="$HOME/.zsh_codex"
fi

# run check_codex_credentials.py in ZSH_CODEX_HOME directory
# and check if it returns 0
if [[ $(python3 "$ZSH_CODEX_HOME/check_codex_credentials.py") -eq 0 ]]; then
    # If it returns 0, then set ZSH_CODEX_CREDENTIALS_VALID to 1
    ZSH_CODEX_CREDENTIALS_VALID=1
else
    # If it returns 1, then set ZSH_CODEX_CREDENTIALS_VALID to 0
    ZSH_CODEX_CREDENTIALS_VALID=0
fi

# Check if ZSH_CODEX_CREDENTIALS_VALID is 0
if [[ $ZSH_CODEX_CREDENTIALS_VALID -eq 0 ]]; then
    # Remind user to set up credentials
    echo "Please set up your Codex credentials by running setup_codex_credentials.py" 
fi


# ZLE function for accept-line
function codex-accept-line () {
    # Get the current buffer
    local buffer=$BUFFER
    # if the buffer does not start with "codex>", then accept the line
    if [[ $buffer != "# "* ]]; then
        zle accept-line
    fi

    # Check if the buffer starts with "codex>" and does not contain ::
    if [[ $buffer == "# "* ]]; then
        # Record it to the buffer
        print -S $buffer

        # if it does remove the "# " from the buffer
        buffer=${buffer:2}
        
        # Display searching message
        echo "\nFetching Codex suggestion..."
        
        # if it does, then send the buffer to codex.py
        # and set the buffer to the output of codex.py
        BUFFER=$(python3 "$ZSH_CODEX_HOME/codex.py" "#$buffer")
        # highlight the buffer after new line
        # zle highlight "$ZSH_CODEX_HIGHLIGHT_COLOR" "$BUFFER"
        # redraw the buffer
        zle redisplay
        # set the cursor to the end of the buffer
        zle end-of-line
    fi
} 

# bind the function codex-accept-line to newline
zle -N codex-accept-line
# bind key "enter" to codex-accept-line
bindkey "^M" codex-accept-line
