#!/bin/bash

# Verifica se o Xcode está aberto
if pgrep -x "Xcode" >/dev/null; then
    # Se estiver aberto, force-quit
    echo "Xcode is open. Force quitting..."
    pkill -9 "Xcode"
    echo "Xcode was closed."
else
    # Se não estiver aberto, não faça nada
    echo "Xcode is already closed."
fi
