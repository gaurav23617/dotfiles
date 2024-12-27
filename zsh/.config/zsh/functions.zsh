# function brew() {
#   if [[ $1 == "add" ]]; then
#     # Remove the first argument ("add")
#     shift
#     # Install the package
#     command brew install "$@"
#     # Update the global Brewfile
#     command brew bundle dump --global --force
#   else
#     # Call the original brew command with all original arguments
#     command brew "$@"
#   fi
# }

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
  alias catt="bat --theme \"Visual Studio Dark+\""
fi
