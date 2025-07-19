# Path configuration

export PATH=$PATH:/opt/local/bin
export PATH=$PATH:$HOME/.bin
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH
export PATH=$HOME/.node_modules_global/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

export PATH=~/.console-ninja/.bin:$PATH

export SYSTEM_MODEL=$(system_profiler SPHardwareDataType | awk '/Model Identifier/ {print $3}')
