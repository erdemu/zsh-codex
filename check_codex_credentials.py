import keyring
import sys

if __name__ == "__main__":
    key = keyring.get_password("zsh_codex_open_ai_api_key", "key") 
    if key is None:
        sys.exit(1)    
    else:
        sys.exit(0)
    