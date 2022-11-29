import keyring
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--set', action='store_true', help='Set the API key')
    parser.add_argument('--check', action='store_true', help='Check the API key')
    parser.add_argument('--overwrite', action='store_true', help='Overwrite the API key')
    args = parser.parse_args()
    if args.set:
        key = keyring.get_password("zsh_codex_open_ai_api_key", "key") 
        if key is None:
            key = input("Enter the API key: ")
            keyring.set_password("zsh_codex_open_ai_api_key", "key", key)
            print("API key set")
        else:
            print("API key already set")
    elif args.check:
        key = keyring.get_password("zsh_codex_open_ai_api_key", "key")
        print(key)
    elif args.overwrite:
        key = input("Enter the API key: ")
        keyring.set_password("zsh_codex_open_ai_api_key", "key", key)
        print("API key set")

if __name__ == "__main__":
    main()
 