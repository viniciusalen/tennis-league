# Comando padrão para executar o script
generate:
	scripts/./killXcode.sh $(close)
	scripts/./run_xcodegen.sh

template:
	@sh -c "cd ArchitectureTemplate; swiftc install.swift -o ./install; ./install"
	@rm ArchitectureTemplate/install
