# zsh-codex

TODO: write docs
TODO: Update the gif with "# " prompt

![](images/simple.gif)

Simple usage

- Install python requirements by pip install -r requirements.txt
- set your api key using setup_codex_credentials --set,
- set root folder of where you put these files to ZSH_CODEX_HOME
- source zsh_codex.zsh

Your prompt will look and behave the same, until you press enter. Each new line is intercepted by the tool, if the new line starts with "# ", it is then being used for generating a new completion using openai api. Suggestion written into a new line, then you're free to accept or modify or delete it as you wish.

The original prompt starting with "# " is also written into the history so you can modify it as well by pressing the up arrow.

Feel free to improve (such as adding copy to clip board key combo, color hacks)

This is what I came up within 2 hours after being inspired by excellent [warp terminal](https://www.warp.dev) and disagreeing with their closed-source policy. I think a terminal client from a 3rd party should always be open source for privacy reasons.

### LICENSE

MIT
