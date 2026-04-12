# shortcuts
alias k kubectl
alias gitlog 'git log --all --graph --decorate'
alias pwdgen 'head /dev/urandom | tr -dc A-Za-z0-9 | head -c32'

# envsource for fish (cf. `source .envfile`)
# https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc
function envsource
    set -f envfile "$argv"
    if not test -f "$envfile"
        echo "Unable to load $envfile"
        return 1
    end
    while read line
        if not string match -qr '^#|^$' "$line"
            set item (string split -m 1 '=' $line)
            set -gx $item[1] $item[2]
            echo "Exported key $item[1]"
        end
    end <"$envfile"
end
