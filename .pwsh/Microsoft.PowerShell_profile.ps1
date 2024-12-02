Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadlineKeyHandler -Key "UpArrow" -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key "DownArrow" -Function HistorySearchForward
Set-PSReadLineOption -Colors @{ InlinePrediction = '#898c5b' }
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -HistorySavePath "$HOME\PSReadLine_History.txt"
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -Colors @{
    InlinePrediction = '#6a8759';
}
Set-PSReadLineOption -HistorySearchCaseSensitive:$false
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true

Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Backspace -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Key Ctrl+z -Function Undo
Set-PSReadLineKeyHandler -Key Ctrl+shift+z -Function Redo
Set-PSReadLineKeyHandler -Key Ctrl+Shift+LeftArrow -Function SelectShellBackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Shift+RightArrow -Function SelectShellForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+a -Function SelectAll

Set-PSReadLineKeyHandler -Key "RightArrow" -ScriptBlock {
       param($key, $arg)

       $line = $null
       $cursor = $null
       [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

       if ($cursor -lt $line.Length) {
           [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
       } else {
           [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
       }
}

Set-PSReadLineKeyHandler -Key End -ScriptBlock {
       param($key, $arg)

       $line = $null
       $cursor = $null
       [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

       if ($cursor -lt $line.Length) {
           [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine($key, $arg)
       } else {
           [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion($key, $arg)
       }
}

function config {
    git --git-dir=$HOME\dotfiles --work-tree=$HOME $args
}


$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
