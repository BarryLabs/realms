#!/etc/profiles/per-user/chandler/bin/nu

let folders = $it | split-column ':' | to list

if $args.len() == 1 {
    let selected = $args[0]
} else {
    let selected = (fd --type d --max-depth 1 . $folders | fzf --preview '')
}

let selected_name = ($selected | basename | str replace '.' '_')

if $env.ZELLIJ_SESSION_NAME {
    echo "You are in a Zellij Session! Please use the session manager to switch sessions." | stderr
} else {
    cd $selected
    zellij --layout zellij-ps attach -c $selected_name options
}
