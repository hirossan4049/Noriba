.PHONY: setup
setup:
	if hash tuist 2>/dev/null; then\
		tuist generate;\
	else\
		echo "\nPlease install tuist: https://tuist.io/";\
	fi

.PHONY: edit
edit:
	if hash tuist 2>/dev/null; then\
		tuist edit;\
	else\
		echo "\nPlease install tuist: https://tuist.io/";\
	fi

